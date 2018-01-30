addpath(genpath('extra_functions'));

dataX=full( mmread('data/fully_proessed_data/processed_data_jurkat/whole_matrix_ip2matlab_jurkat_nofilter') );
actual_labels=get_numeric_labels_jurkat();



rng(1)
k=2;% k=11 for pbmc, k=2 for jurkat, k=13 for zygote
loc=randperm(size(dataX,1),k);

inputdata=dataX;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_orig=ari



load('saved/jurkat_1000_4000.mat')
arr=double(reshape(arr,[3388,1000]));


inputdata=arr;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_ae=ari

%%
%no imp, scimp, mcimp, 2L,  magic_without, magic_with: 
%0.9871 0.9859 0.9871 0.9871 0.9719 0.9824


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GRID SEARCH   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








fro_error1=[];
aris1=[];
disp('First for');

hus=[1100 1500 2000];
 for i=1:length(hus)
     
%name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=11,',num2str(RANK)),'_sr100.mat');
name=strcat(strcat('saved/1_',num2str(hus(i))),'.mat');
load(name);
arr=double(reshape(arr,[3388,1000]));

Xrec=arr;

fro_error1=[fro_error1 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
%rng(rn)
inputdata=arr;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris1=[aris1 ari];
 end




