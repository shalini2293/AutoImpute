%%scImpute




l1=[];l2=[];l3=[];
for i=10:10:50
%%scImpute  --scImpute works on fully processed data..present in this directory  
%{
load(['mousebrain' num2str(i) '.0.mat']); dataX=double(reshape(arr,[280,1000]));
load(['zygote_' num2str(i) '.0.mat']); dataX=double(reshape(arr,[317,1000]));
load(['jurkat_' num2str(i) '.0.mat']); dataX=double(reshape(arr,[3388,1000]));

name=['D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/recoveredSubSampledMatrices/mouseBrain_diffSamplingRatios/scimpute_count_' num2str(i) '.csv']
name=['D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/recoveredSubSampledMatrices/zygote_diffSamplingRatios/scimpute_count_' num2str(i) '.csv']
name=['D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/recoveredSubSampledMatrices/jurkat_diffSamplingRatios/scimpute_count_' num2str(i) '.csv']
Xrec=csvread(name,1,1);
Xrec=Xrec';
%}

%%MAGIC

magic_dir='D:/AanchalMongia_phdClg/Phd/Matlab/MatlabWorkspace/Prob4_mcImpute_deep/comparison-MAGIC/matlab/';
%for zygote n jurkat
load([magic_dir 'maked_raw_matrices(after gene filtering done in magic)/zygote_' num2str(i) '.mat']);
%for mousebrain
%load([magic_dir 'maked_raw_matrices(NO gene filtering done in magic)/jurkat_' num2str(i) '.mat']);
dataX=dataMasked;

N = numel(dataX);
t = randperm(N);
IDX = t(1:SAMPLING_RATIO_ulta*N);
M=ones(N,1); M(IDX)=0;


load([magic_dir 'recovered_matrices_from_rawMaskedMatrices/zygote_MAGIC_' num2str(i) '.mat']);
%Xrec loaded in workspace



fro_error=norm(Xrec-dataX, 'fro')/norm(dataX,'fro'); l1=[l1 fro_error];
RMSE = sqrt(mean((Xrec(:) - dataX(:) ).^2)); l2=[l2 RMSE];
MAE= mean(abs(Xrec(:)-dataX(:))); l3=[l3 MAE];
end
%}
%

l1=fliplr(l1); l2=fliplr(l2); l3=fliplr(l3); 
plot(log(l1));hold on; plot(log(l2)); hold on;plot(log(l3));ylabel('log(error))');legend('nmse','rmse','mae')
%fro
%1.0e+10 *
%1.9920    0.0000    0.0000    0.0000    0.0000

%rmse
%1.0e+10 *

    %4.0270    0.0000    0.0000    0.0000    0.0000
    
%mae
%1.0e+07 *

    %9.0724    0.0003    0.0001    0.0000    0.0000
