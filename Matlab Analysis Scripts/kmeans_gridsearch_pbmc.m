addpath(genpath('extra_functions'));
dataX=csvread('data/fully_proessed_data/processed_data_pbmc/68kdata/whole_matrix.csv',1,0);
actual_labels=get_numeric_labels_pbmc();



rng(1)
k=11;% k=11 for pbmc, k=2 for jurkat, k=13 for zygote


inputdata=dataX;
%load('RecMatrices/pbmc_kmeans_initialization_samplenumbers')
loc=randperm(size(inputdata,1),k);


init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_orig=ari



load('data/best/best/saved_models_pbmc/pbmc_12000_3000.mat')
arr=double(reshape(arr,[68579,1000]));
Xrec=arr;

fro_error_ae=norm(Xrec-dataX, 'fro')/norm(dataX,'fro');

inputdata=arr;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris_ae=ari

 



%%1 layer grid search

f1=[];
a1=[];
RANKS=[2 3 4 5 6 7 8 9 10 11 12 13 14 15 20 25 30 35 40 45 50];%11 12 13 14 not in jurkat
    for i=1:length(RANKS)
            RANK=RANKS(i)
            
            name=strcat(strcat('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r',num2str(RANK)),'.mat');
            load(name);

            f1=[f1 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
            %rng(rn)
            inputdata=Xrec;
            init =inputdata(loc,:);
            predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
            [~,ari]=getRiAri(actual_labels,predicted_labels);
            a1=[a1 ari];
            
    end
%%  
  
%%2 layer    
name=strcat(strcat('RecMatrices/2Layer/RecMatrices_pbmc/RecMatrix_2L_r=11,',num2str(5)),'_sr100.mat');
load(name)
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_2L=ari



fro_error0=[];
aris0=[];
disp('Zeroth for');
 for RANK= 2:2:10
     
%name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=10,',num2str(RANK)),'_sr100.mat');
name=strcat(strcat('RecMatrices/2Layer/RecMatrices_pbmc/RecMatrix_2L_r=10,',num2str(RANK)),'_sr100.mat');
load(name);

fro_error0=[fro_error0 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
%rng(rn)
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris0=[aris0 ari];


 end
 aris0
%}

fro_error1=[];
aris1=[];
disp('First for');
 for RANK= 2:1:11
     
%name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=11,',num2str(RANK)),'_sr100.mat');
name=strcat(strcat('RecMatrices/RecMatrices_pbmc/RecMatrix_2L_r=11,',num2str(RANK)),'_sr100.mat');
load(name);

fro_error1=[fro_error1 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
%rng(rn)
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris1=[aris1 ari];
 end
 aris1
%}


aris2=[];
fro_error2=[]; 
 disp('Second for');
for RANK= 10:10:100%100
     
%name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=100,',num2str(RANK)),'_sr100.mat');
 name=strcat(strcat('RecMatrices/RecMatrices_pbmc/RecMatrix_2L_r=100,',num2str(RANK)),'_sr100.mat');
load(name);

fro_error2=[fro_error2 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
%rng(rn)
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris2=[aris2 ari];
end
aris2

aris3=[];
fro_error3=[];
disp('Third for');
for RANK= 50:50:500
      
%name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=300,',num2str(RANK)),'_sr100.mat');
name=strcat(strcat('RecMatrices/RecMatrices_pbmc/RecMatrix_2L_r=500,',num2str(RANK)),'_sr100.mat');
load(name);


fro_error3=[fro_error3 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
%rng(rn)
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris3=[aris3 ari];

end
aris3

%}
%save(strcat(strcat('froErrors_and_aris_RNG=',num2str(rn)),'.mat'),'ari_orig','fro_error0','aris0','fro_error2','aris2','fro_error3','aris3')
save(strcat(strcat('froErrors_and_aris_RNG=',num2str(rn)),'.mat'),'ari_orig','fro_error0','aris0', 'fro_error1','aris1','fro_error2','aris2','fro_error3','aris3')

