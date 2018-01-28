from __future__ import division, print_function, absolute_import
import os
import argparse
import datetime
import matplotlib
import numpy as np
import scipy.io
import tensorflow as tf
from sklearn.metrics import mean_absolute_error, mean_squared_error
	
matplotlib.use('Agg')

import matplotlib.pyplot as plt

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
os.environ["CUDA_VISIBLE_DEVICES"]="1"

parser = argparse.ArgumentParser(description = 'AE based MC.')

parser.add_argument('--debug', type = str, nargs = '+', help = "Want debug statements.", choices = ['yes', 'no'])
parser.add_argument('--mask', type = float, nargs = '+', help = "Percentage of masking required. Like 10, 20, 12.5 etc")

args = parser.parse_args()

initTime1 = datetime.datetime.now()

masking_precentage = args.mask[0]
masking_precentage = masking_precentage/100.0

userItemMatrix = scipy.io.mmread("../../fully_proessed_data/processed_data_jurkat/whole_matrix_ip2matlab_jurkat_nofilter")

userItemMatrix = userItemMatrix.toarray()
userItemMatrix = np.array(userItemMatrix)
num_features = userItemMatrix.shape[1]
data_entries = userItemMatrix.shape[0]
X = tf.placeholder("float32", [None, num_features])
mask = tf.placeholder("float32", [None, num_features])

idxi, idxj = np.nonzero(userItemMatrix)

ix = np.random.choice(len(idxi), int(np.floor(masking_precentage * len(idxi))), replace = False)
store_for_future = userItemMatrix[idxi[ix], idxj[ix]]
indices = idxi[ix], idxj[ix]

userItemMatrix[idxi[ix], idxj[ix]] = 0  # making masks 0
matrix_mask = userItemMatrix.copy()
matrix_mask[matrix_mask.nonzero()] = 1 

scipy.io.savemat("jurkat_" + str(masking_precentage*100) + ".mat", mdict = {"arr" : userItemMatrix})

learning_rate = 1e-3
hidden_layer = 4000
lambda_val = 1000

mae = []
rmse = []
nmse = []

weights = {
	'encoder_h1': tf.Variable(tf.random_normal([num_features, hidden_layer])),
	'decoder_h1': tf.Variable(tf.random_normal([hidden_layer, num_features])),
	}
biases = {
	'encoder_b1': tf.Variable(tf.random_normal([hidden_layer])),
	'decoder_b1': tf.Variable(tf.random_normal([num_features])),
}

def encoder(x):
	layer_1 = tf.nn.sigmoid(tf.add(tf.matmul(x, weights['encoder_h1']), biases['encoder_b1']))
	return layer_1

def decoder(x):
	layer_1 = tf.add(tf.matmul(x, weights['decoder_h1']), biases['decoder_b1'])
	return layer_1

encoder_op = encoder(X)
decoder_op = decoder(encoder_op)

y_pred = decoder_op
y_true = X		
rmse_loss = tf.pow(tf.norm(y_true - y_pred * mask), 2)
regularization = tf.multiply(tf.constant(lambda_val/2.0, dtype="float32"), tf.add(tf.pow(tf.norm(weights['decoder_h1']), 2), tf.pow(tf.norm(weights['encoder_h1']), 2)))
loss = tf.add(tf.reduce_mean(rmse_loss), regularization)
optimizer = tf.train.RMSPropOptimizer(learning_rate).minimize(loss)

display_step = 1

init = tf.global_variables_initializer()
with tf.Session() as sess:
	sess.run(init)
	num_steps = 6000
	prev_loss = 0
	threshold = 1e-3
	for k in range(1, num_steps+1):
		_, l = sess.run([optimizer, rmse_loss], feed_dict={X: userItemMatrix, mask: matrix_mask})
		lpentry = l/data_entries
		print (lpentry)
		change = abs(prev_loss - lpentry)
		if ( change <= threshold):
			print("Reached the threshold value.")
			break
		prev_loss = lpentry
		if( args.debug[0] == 'yes' ):
			if k % display_step == 0 or k == 1:
				print('Step %i : Loss: %f <-> %f, %f' % (k, l, lpentry, change))
	trained_data = sess.run([y_pred], feed_dict={X: userItemMatrix, mask: matrix_mask})
	
	predictions = []

	for idx, value in enumerate(store_for_future):
		prediction = trained_data[0][indices[0][idx], indices[1][idx]]
		predictions.append(prediction)


store_for_future = np.array(store_for_future)
predictions = np.array(predictions)

print("<------------------------------------Statistics for jurkat dataset------------------------------------>")
print("MAE = {0}".format( mean_absolute_error(store_for_future, predictions) ))
print( "RMSE = {0}".format( mean_squared_error(store_for_future, predictions) ** 0.5 ))
print("NMSE = {0}".format( (np.linalg.norm(store_for_future - predictions) / np.linalg.norm(store_for_future)) ))

initTime2 = datetime.datetime.now()
print("Total time taken = {0}".format(initTime2 - initTime1))