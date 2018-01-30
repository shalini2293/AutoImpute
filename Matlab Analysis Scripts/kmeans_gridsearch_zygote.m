addpath(genpath('extra_functions'));

dataX=full( mmread('data/fully_proessed_data/processed_data_zygote/whole_matrix_ip2matlab_zygote') );
actual_labels=get_numeric_labels_zygote();



rng(1)
k=13;% k=11 for pbmc, k=2 for jurkat, k=13 for zygote

loc=randperm(size(dataX,1),k);

inputdata=dataX;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_orig=ari

load('saved/zygote_2000_4000.mat')
arr=double(reshape(arr,[317,1000]));


inputdata=arr;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_ae=ari


%%%%%%code hree









%%1 layer grid search

f1=[];
a1=[];
RANKS=[2 3 4 5 6 7 8 9 10 11 12 13 14 15 20 25 30 35 40 45 50];%11 12 13 14 not in jurkat
    for i=1:length(RANKS)
            RANK=RANKS(i)
            
            name=strcat(strcat('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r',num2str(RANK)),'.mat');
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
name=strcat(strcat('RecMatrices/2Layer/RecMatrices_zygote_freezed/RecMatrix_2L_r=13,',num2str(11)),'_sr100.mat');
load(name)
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_2L=ari

load('comparison-MAGIC/matlab/magic_zygote_withoutLogTransform.mat')
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_magicwithout=ari

load('comparison-MAGIC/matlab/magic_zygote_withLogTransform.mat')
inputdata=Xrec;
init =inputdata(loc,:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
ari_magicwith=ari

%no imp, scimp, mcimp, 2L, magic_without, magic_with: 
%0.385 0.391 0.508 0.5322 0.3715 0.4246

fro_error0=[];
aris0=[];
disp('Zeroth for');
 for RANK= 2:2:10
     
name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=10,',num2str(RANK)),'_sr100.mat');
load(name);

fro_error0=[fro_error0 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
rng(rn)
inputdata=Xrec;
init =inputdata(randperm(size(inputdata,1),k),:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris0=[aris0 ari];


 end

fro_error1=[];
aris1=[];
disp('First for');
 for RANK= 2:1:13
     
name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=13,',num2str(RANK)),'_sr100.mat');
load(name);

fro_error1=[fro_error1 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
rng(rn)
inputdata=Xrec;
init =inputdata(randperm(size(inputdata,1),k),:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris1=[aris1 ari];
 end
%}


aris2=[];
fro_error2=[]; 
 disp('Second for');
for RANK= 10:10:100%100
     
name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=100,',num2str(RANK)),'_sr100.mat');
load(name);

fro_error2=[fro_error2 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
rng(rn)
inputdata=Xrec;
init =inputdata(randperm(size(inputdata,1),k),:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris2=[aris2 ari]
end

aris3=[];
fro_error3=[];
disp('Third for');
for RANK= 50:50:300
      
name=strcat(strcat('RecMatrices/RecMatrices_zygote/RecMatrix_2L_r=300,',num2str(RANK)),'_sr100.mat');
load(name);


fro_error3=[fro_error3 norm(Xrec-dataX, 'fro')/norm(dataX,'fro')];
rng(rn)
inputdata=Xrec;
init =inputdata(randperm(size(inputdata,1),k),:);
predicted_labels=kmeans(inputdata,k,'MaxIter',1000,'Start',init);%without impu
[~,ari]=getRiAri(actual_labels,predicted_labels);
aris3=[aris3 ari];

end
%}
%save(strcat(strcat('froErrors_and_aris_RNG=',num2str(rn)),'.mat'),'ari_orig','fro_error0','aris0','fro_error2','aris2','fro_error3','aris3')
save(strcat(strcat('froErrors_and_aris_RNG=',num2str(rn)),'.mat'),'ari_orig','fro_error0','aris0', 'fro_error1','aris1','fro_error2','aris2','fro_error3','aris3')

