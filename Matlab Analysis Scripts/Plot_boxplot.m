%to convert boxplot to density plot...A,B,C.. represent dataset and each
%value in these represent technique (no_imp,scimp,drimp,etc)


fs=14;
A=[];
disp('ZYGOTE')
figure;
anno=get_numeric_labels_zygote();

zygote_cellfiltered_genepruned_median_normed=csvread('data/median_normalized_data/zygote_MedianNormalized.csv',1,0);
%dataX=full( mmread('data/fully_proessed_data/processed_data_zygote/whole_matrix_ip2matlab_zygote') );
%X=dataX;
X=zygote_cellfiltered_genepruned_median_normed;

ind=find(anno==1);
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,1)
bplot(cv2,2);
%title('No Imputation')
cv2(isnan(cv2))=[];
med_noimp=median(cv2)
A=[A med_noimp];
hold on;


Xrec=csvread('D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/zygote/scimpute_count.csv',1,1);
X=exp(Xrec')-1;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,2)
bplot(cv2,8);
cv2(isnan(cv2))=[];
med_sc=median(cv2)
A=[A med_sc];
%title('scImpute

hold on;
load('D:/AanchalMongia_phdClg/Phd/R_workspace/drImpute/drimpute_imputed_matrix_zygote.mat')
X=exp(drimpute_imputed_matrix_zygote)-1;

X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,14);
cv2(isnan(cv2))=[];
med_dr=median(cv2)
A=[A med_dr];


load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_zygote_withoutLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,20);
med_magic_without=median(cv2)
A=[A med_magic_without];

%{
load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_zygote_withLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,20);
med_magic_with=median(cv2)
A=[A med_magic_with];
%}


hold on;
load('data/best/best/saved_models_zygote/zygote_2000_4000.mat')
arr=double(reshape(arr,[317,1000]));
X=exp(arr)-1;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot((cv2),26);
med_ae=median(cv2)
A=[A med_ae];

%{
hold on;

Xrec=csvread('C:/Users/Aanchal/Desktop/AanchalMongia_phdClg/Phd/R_workspace/scImpute/zygote/scimpute_count.csv',1,1);
X=Xrec';
%{
load('RecMatrices/RecMatrices_zygote_freezed/RecMatrix_r13_sr100.mat')
X=Xrec;
%}
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,8);
median(cv2)
hold on;

%{
load('RecMatrices/RecMatrices_zygote_freezed/RecMatrix_r13_sr100.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,14);
median(cv2)
%}

%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r12.mat')
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r13.mat')
load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r14.mat')
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r50.mat')

X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,14);
median(cv2)


%load('RecMatrices/RecMatrices_zygote_freezed/RecMatrix_2L_r=13,2_sr100.mat')
load('RecMatrices/2Layer/RecMatrices_zygote_freezed/RecMatrix_2L_r=13,11_sr100.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,20);
median(cv2)

load('comparison-MAGIC/matlab/magic_zygote_withoutLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,26);
median(cv2)

load('comparison-MAGIC/matlab/magic_zygote_withLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,32);
median(cv2)
%}

title('Preimplantation dataset')
ylabel('Log of Coefficient of variance','FontSize',fs)
%title('Box plots for "Pbmc" Dataset: Subpopulation-> CD34+');
%xticks([2 8 14 20 26])
%xticklabels({'No imputation','scImpute','drImpute','MAGIC','AutoImpute'})
set(gca,'XTick',[2 8 14 20 26], 'XTickLabel', {'No imputation','scImpute','drImpute','MAGIC','AutoImpute'}, 'fontsize', 11)

%set(gca,'xtick',['a','b'])


    
%%
disp('JURKAT')
B=[];
figure;
anno=get_numeric_labels_jurkat();

%dataX=full( mmread('data/fully_proessed_data/processed_data_jurkat/whole_matrix_ip2matlab') );
%X=dataX;
jurkat_genepruned_median_normed=csvread('data/median_normalized_data/jurkat_nofilter_MedianNormalized.csv',1,0);
X=jurkat_genepruned_median_normed;

ind=find(anno==1);
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,1)
cv2(isnan(cv2))=[];
bplot(cv2,2);
no=median(cv2)
B=[B no];

hold on;
%Xrec=csvread('C:/Users/Aanchal/Desktop/AanchalMongia_phdClg/Phd/R_workspace/scImpute/jurkat/scimpute_count.csv',1,1);
Xrec=csvread('D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/nofilter_jurkat/scimpute_count.csv',1,1);
X=exp(Xrec')-1;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,2)
cv2(isnan(cv2))=[];
bplot(cv2,8);%or boxplot
sc=median(cv2)
B=[B sc];

hold on;
load('D:/AanchalMongia_phdClg/Phd/R_workspace/drImpute/drimpute_imputed_matrix_jurkat.mat')
X=exp(drimpute_imputed_matrix_jurkat')-1;

X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
cv2(isnan(cv2))=[];
bplot((cv2),14);
dr=median(cv2)
B=[B dr];

hold on;
load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_jurkat_withoutLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
cv2(isnan(cv2))=[];
bplot(cv2,20);
mag_without=median(cv2)
B=[B mag_without];

%{
hold on;
load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_jurkat_withLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
cv2(isnan(cv2))=[];
bplot(cv2,20);
mag_with=median(cv2)
B=[B mag_with];
%}

%{
hold on;
%load('RecMatrices/RecMatrices_jurkat/RecMatrix_r3_sr100.mat')
%load('RecMatrices/RecMatrices_jurkat/NOFILTER_RecMatrix_r3_sr100.mat')
%X=Xrec;
Xrec=csvread('C:/Users/Aanchal/Desktop/AanchalMongia_phdClg/Phd/R_workspace/scImpute/nofilter_jurkat/scimpute_count.csv',1,1);
X=Xrec';
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,14);
median(cv2)


hold on
load('mcImputeRecMatrices/Jurkat/NOFILTER_RecMatrix_r3_sr100.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,8);
median(cv2)
%}

hold on;
load('data/best/best/saved_models_jurkat/jurkat_1000_4000.mat')
arr=double(reshape(arr,[3388,1000]));
X=exp(arr)-1;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
cv2(isnan(cv2))=[];
bplot(cv2,26);
ae=median(cv2)
B=[B ae];

%{
hold on;
load('RecMatrices/1Layer/RecMatrices_jurkat/RecMatrix_1L_r5.mat')
%load('RecMatrices/1Layer/RecMatrices_jurkat/RecMatrix_1L_r50.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,2)
bplot(cv2,14);%or blot
median(cv2)


hold on;
load('RecMatrices/2Layer/RecMatrices_jurkat/RecMatrix_2L_r=5,2_sr100.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,2)
bplot(cv2,20);%or blot
median(cv2)

load('comparison-MAGIC/matlab/magic_jurkat_withoutLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,26);
median(cv2)

load('comparison-MAGIC/matlab/magic_jurkat_withLogTransform.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,3,3)
bplot(cv2,32);
median(cv2)
%}
title('Jurkat-293T dataset')
ylabel('Log of Coefficient of variance','FontSize',fs)
%title('Box plots for "Pbmc" Dataset: Subpopulation-> CD34+');
%xticks([2 8 14 20 26])
%xticklabels({'No imputation','scImpute','drImpute','MAGIC','AutoImpute'})
set(gca,'XTick',[2 8 14 20 26], 'XTickLabel', {'No imputation','scImpute','drImpute','MAGIC','AutoImpute'}, 'fontsize', 11)



D=[];
disp('PBMC')
figure;
anno=get_numeric_labels_pbmc();

Pbmc_genepruned_median_normed=csvread('data/median_normalized_data/Pbmc_MedianNormalized.csv',1,0);
X=Pbmc_genepruned_median_normed;  


ind=find(anno==1); %3,5,7,8,11
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,1)
bplot(cv2,2);%or blot
cv2(isnan(cv2))=[];
median_cv2_noimp=median(cv2)
D=[D median_cv2_noimp];
%{
hold on;
load('mcImputeRecMatrices/Pbmc/RecMatrix_r11_sr100.mat')
%load('RecMatrices/RecMatrices_pbmc/NEWWWRecMatrix_r11_sr100.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,2)
bplot(cv2,8);%or blot
median(cv2)


hold on;
%load('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r4.mat')
load('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r10.mat')
%load('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r11.mat')
%load('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r50.mat')
%load('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r50.mat')
%load('RecMatrices/1Layer/RecMatrices_pbmc/RecMatrix_1L_r10.mat')

X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,2)
bplot(cv2,8);%or blot
median(cv2)

hold on;
load('RecMatrices/2Layer/RecMatrices_pbmc/RecMatrix_2L_r=11,5_sr100.mat')
X=Xrec;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,2)
bplot(cv2,14);%or blot
median(cv2)
%}


D=[D nan];
D=[D nan];
D=[D nan];

hold on;
load('data/best/best/saved_models_pbmc/pbmc_12000_3000.mat')
arr=double(reshape(arr,[68579,1000]));
X=exp(arr)-1;
X=X(ind,:);
cv2=var(X)./mean(X).^2;
%subplot(1,2,2)
bplot(cv2,8);%or blot
median_cv2_ae=median(cv2)
D=[D median_cv2_ae];

title('PBMC dataset')
ylabel('Log of Coefficient of variance','FontSize',fs)
%title('Box plots for "Pbmc" Dataset: Subpopulation-> CD34+');
%xticks([2 8 14 20 26])
%xticklabels({'No imputation','scImpute','drImpute','MAGIC','AutoImpute'})
set(gca,'XTick',[2 8], 'XTickLabel', {'No imputation','AutoImpute'}, 'fontsize', 11)

%{
dist=2;
y=[A;B;C;D];
%y=log(y);
x = 1:dist:(1+(size(y,1)-1)*dist) ;

b=bar(x',y,'grouped')
xticklabels({'Preimplantation','Jurkat','MouseBrain','Pbmc'})
ylabel('Coefficient of variance')
%ylim([0 0.08])
hLg=legend({'No Imputation';'scImpute';'drImpute';'Magic';'AutoImpute'}); legend('boxoff') % add legend
%ylim([0 0.08])

width = b.BarWidth;
y=[A;B;C;D];
y=round(y,4);
for i=1:length(y(:, 1))
i
    row = y(i, :);
    % 0.5 is approximate net width of white spacings per group
    offset = ((width+1) / (length(row))) ;
    x = linspace(0.40*i-offset, 2*i+offset, length(row));
    text(x,row,num2str(row'));
end
%}