from __future__ import division, print_function, absolute_import
import os
import argparse
import datetime
import matplotlib
import numpy as np
import scipy.io
import tensorflow as tf
	
matplotlib.use('Agg')

import matplotlib.pyplot as plt

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
os.environ["CUDA_VISIBLE_DEVICES"]="0"

parser = argparse.ArgumentParser(description = 'aeImpute')

parser.add_argument('--debug', type = str, nargs = '+', help = "Want debug statements.", choices = ['yes', 'no'])

args = parser.parse_args()

initTime1 = datetime.datetime.now()

userItemMatrix = scipy.io.mmread("../../whole_matrix_ip2matlab_zygote")

userItemMatrix = userItemMatrix.toarray()
userItemMatrix = np.array(userItemMatrix)
num_features = userItemMatrix.shape[1]
data_entries = userItemMatrix.shape[0]
print(num_features)
X = tf.placeholder("float32", [None, num_features])
mask = tf.placeholder("float32", [None, num_features])


matrix_mask = userItemMatrix.copy()
matrix_mask[matrix_mask.nonzero()] = 1 

learning_rate = 1e-3
num_hidden_1 = [4000]
lambda_list = [2000]

for hidden_layer_1 in num_hidden_1:
	for lambda_val in lambda_list:
		print("lambda : " + str(lambda_val))
		print("hidden layer : " + str(hidden_layer_1))
		weights = {
			'encoder_h1': tf.Variable(tf.random_normal([num_features, hidden_layer_1])),
			'decoder_h1': tf.Variable(tf.random_normal([hidden_layer_1, num_features])),
			}
		biases = {
			'encoder_b1': tf.Variable(tf.random_normal([hidden_layer_1])),
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
		# optimizer = tf.train.RMSPropOptimizer(learning_rate).minimize(rmse_loss)

		display_step = 1

		init = tf.global_variables_initializer()
		with tf.Session() as sess:
			sess.run(init)
			num_steps = 10000
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
			scipy.io.savemat("zygote_" + str(lambda_val) + "_" + str(hidden_layer_1) + ".mat", mdict = {"arr" : trained_data})

initTime2 = datetime.datetime.now()
print("Total time taken = {0}".format(initTime2 - initTime1))
