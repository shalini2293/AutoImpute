fs=14
%we use original annotations fil1 bcz in zygote dataset, no row/sample was
%filtered in filter_cell()
anno=get_numeric_labels_jurkat();


jurkat_genepruned_median_normed=csvread('data/median_normalized_data/jurkat_nofilter_MedianNormalized.csv',1,0);
X=jurkat_genepruned_median_normed;



figure;

ind=find(anno==1);%1/2 chnge title also

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(struct('tran',1,'data',corr_vector));
%bar(corr_vector);
%save('corr_vector_293t.mat','corr_vector');
corr_vector1=corr_vector;



hold on;
load('saved/jurkat_1000_4000.mat')
arr=double(reshape(arr,[3388,1000]));
X=arr;
A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(struct('tran',1,'data',corr_vector));
corr_vector_ae =corr_vector 

hold on;
%Xrec=csvread('C:/Users/Aanchal/Desktop/AanchalMongia_phdClg/Phd/R_workspace/scImpute/jurkat/scimpute_count.csv',1,1);
Xrec=csvread('D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/nofilter_jurkat/scimpute_count.csv',1,1);
X=Xrec';

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(struct('tran',1,'data',corr_vector));
%bar(corr_vector);
corr_vector2=corr_vector;




hold on;
load('D:/AanchalMongia_phdClg/Phd/R_workspace/drImpute/drimpute_imputed_matrix_jurkat.mat')
X=drimpute_imputed_matrix_jurkat';

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(struct('tran',1,'data',corr_vector));
corr_vector3=corr_vector;


%{
hold on;
%load('RecMatrices/RecMatrices_jurkat/RecMatrix_r3_sr100.mat')
load('mcImputeRecMatrices/Jurkat/NOFILTER_RecMatrix_r3_sr100.mat')
X=Xrec;


A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(corr_vector);
%bar(corr_vector);
corr_vector3=corr_vector;


hold on;
load('../Prob4_mcImpute_deep/RecMatrices/1Layer/RecMatrices_jurkat/RecMatrix_1L_r5.mat')
%load('RecMatrices/1Layer/RecMatrices_jurkat/RecMatrix_1L_r50.mat')%
X=Xrec;

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
%kde(corr_vector);

hold on;
load('../Prob4_mcImpute_deep/RecMatrices/2Layer/RecMatrices_jurkat/RecMatrix_2L_r=5,2_sr100.mat')
X=Xrec;

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
%kde(corr_vector);
%bar(corr_vector);
corr_vector4=corr_vector;

%}

hold on;

load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_jurkat_withoutLogTransform.mat')
X=Xrec;

A=X(ind,:);
pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(struct('tran',0.3,'data',corr_vector));
corr_vector4=corr_vector;

%{
hold on;

load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_jurkat_withLogTransform.mat')
X=Xrec;

A=X(ind,:);
pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(struct('tran',0.3,'data',corr_vector));
corr_vector5=corr_vector;

%}



%bar([median(corr_vector1) ;median(corr_vector2) ;median(corr_vector3) ], 'FaceColor','flat');
%ylabel('Median of pairwise correlation')
xl=xlabel('Pearson correlation')
yl=ylabel('Density')
leg=legend('No imputation','AutoImpute','scImpute','drImpute','MAGIC')%
leg.FontSize=fs
xl.FontSize=fs
yl.FontSize=fs

LEG=set(leg,'Location','northwest')
set(findall(gca, 'Type', 'Line'),'LineWidth',1.5);

ylim([0 200])
xlim([0 1.05])