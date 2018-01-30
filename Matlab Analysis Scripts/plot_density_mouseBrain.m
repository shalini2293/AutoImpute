
anno=get_numeric_labels_mouseBrain();
X=dlmread('data/median_normalized_data/mouseBrain_MedianNormalized.csv',' ',1,1);



figure;
ind=find(anno==1);%1/3 title('Density: Samples of label 16cell (preimplantation data)')

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(struct('tran',1,'data',corr_vector))
corr_vector1=corr_vector
%{
hold on;

Xrec=csvread('C:/Users/Aanchal/Desktop/AanchalMongia_phdClg/Phd/R_workspace/scImpute/zygote/scimpute_count.csv',1,1);
X=Xrec';


A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(corr_vector)



hold on;

load('RecMatrices/RecMatrices_zygote_freezed/RecMatrix_r13_sr100.mat')
X=Xrec;


A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(corr_vector)

%}

%{
hold on;
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r12.mat')
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r13.mat')
load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r14.mat')
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r50.mat')

X=Xrec;

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(corr_vector);
%}


hold on;
load('data/best/best/mouse_brain/mouseBrain_1_7000_2.mat')
arr=double(reshape(arr,[280,1000]));
X=arr;

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample2.mat','corr_vector','-v6')
kde(struct('tran',1,'data',corr_vector))
corr_vector2=corr_vector


hold on;

Xrec=csvread('D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/mouseBrain/scimpute_count.csv',1,1);
X=Xrec';
A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(struct('tran',1,'data',corr_vector))
corr_vector3=corr_vector

hold on;

load('D:/AanchalMongia_phdClg/Phd/R_workspace/drImpute/drimpute_imputed_matrix_mouseBrain.mat')
X=drimpute_imputed_matrix_mouseBrain';

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(struct('tran',1,'data',corr_vector))
corr_vector4=corr_vector


hold on;

load('D:/AanchalMongia_phdClg/Phd/Matlab/MatlabWorkspace/Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_mouseBrain_withoutLogTransform.mat')
X=Xrec;

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(struct('tran',0.3,'data',corr_vector))
corr_vector5=corr_vector

%{
hold on;

load('D:/AanchalMongia_phdClg/Phd/Matlab/MatlabWorkspace/Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_mouseBrain_withLogTransform.mat')
X=Xrec;

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(struct('tran',0.3,'data',corr_vector))
corr_vector6=corr_vector
%}
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