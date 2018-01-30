addpath(genpath('extra_functions'));

actual_labels=get_numeric_labels_mouseBrain();
dataX=full( mmread('data/fully_proessed_data/processed_data_mouseBrain/whole_matrix_ip2matlab_mouseBrain') );




rng(1)
k=8;% k=8 for mouseBrain k=11 for pbmc, k=2 for jurkat, k=13 for zygote

loc=randperm(size(dataX,1),k);

inputdata=dataX;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_orig=ari


%%scImpute
Xrec=csvread('D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/mouseBrain/scimpute_count.csv',1,1);
Xrec=Xrec';
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_scImp=ari

%% autoImpute


%%drImpute
load('D:/AanchalMongia_phdClg/Phd/R_workspace/drImpute/drimpute_imputed_matrix_mouseBrain.mat')
inputdata=drimpute_imputed_matrix_mouseBrain';
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_drimpute=ari

%%MAGIC
load('D:/AanchalMongia_phdClg/Phd/Matlab/MatlabWorkspace/Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_mouseBrain_withoutLogTransform.mat')
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_magicwithout=ari

