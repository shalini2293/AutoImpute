
%we use original annotations fil1 bcz in zygote dataset, no row/sample was
%filtered in filter_cell()
anno=get_numeric_labels_zygote();

zygote_cellfiltered_genepruned_median_normed=csvread('data/median_normalized_data/zygote_MedianNormalized.csv',1,0);
X=zygote_cellfiltered_genepruned_median_normed;



figure;
ind=find(anno==1);%1/3 title('Density: Samples of label 16cell (preimplantation data)')

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample.mat','corr_vector','-v6')
kde(struct('tran',1,'data',corr_vector))
corr_vector1=corr_vector;

hold on;
load('saved/zygote_2000_4000.mat')
arr=double(reshape(arr,[317,1000]));
X=arr;

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample2.mat','corr_vector','-v6')
kde(struct('tran',1,'data',corr_vector))
corr_vector2=corr_vector;


hold on;

Xrec=csvread('D:/AanchalMongia_phdClg/Phd/R_workspace/scImpute/zygote/scimpute_count.csv',1,1);
X=Xrec';


A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample3.mat','corr_vector','-v6')
kde(struct('tran',1,'data',corr_vector))
corr_vector3=corr_vector;

hold on;

load('D:/AanchalMongia_phdClg/Phd/R_workspace/drImpute/drimpute_imputed_matrix_zygote.mat')
X=drimpute_imputed_matrix_zygote';

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample4.mat','corr_vector','-v6')
kde(struct('tran',1,'data',corr_vector))
corr_vector4=corr_vector;




%{
hold on;

load('RecMatrices/RecMatrices_zygote_freezed/RecMatrix_r13_sr100.mat')
X=Xrec;


A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(corr_vector)



hold on;
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r12.mat')
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r13.mat')
load('../Prob4_mcImpute_deep/RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r14.mat')
%load('RecMatrices/1Layer/RecMatrices_zygote/RecMatrix_1L_r50.mat')

X=Xrec;

A=X(ind,:);

pair_corr=corr(A');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
kde(corr_vector);


hold on;

%load('RecMatrices/RecMatrices_zygote_freezed/RecMatrix_2L_r=13,2_sr100.mat')
load('../Prob4_mcImpute_deep/RecMatrices/2Layer/RecMatrices_zygote_freezed/RecMatrix_2L_r=13,11_sr100.mat')
X=Xrec;

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(corr_vector)
%}

hold on;

load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_zygote_withoutLogTransform.mat')
X=Xrec;

A=X(ind,:);
pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample5.mat','corr_vector','-v6')
kde(struct('tran',0.3,'data',corr_vector))
corr_vector5=corr_vector;

%{
hold on;

load('../Prob4_mcImpute_deep/comparison-MAGIC/matlab/magic_zygote_withLogTransform.mat')
X=Xrec;

A=X(ind,:);
pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample6.mat','corr_vector','-v6')
kde(struct('tran',0.1,'data',corr_vector))
corr_vector6=corr_vector;
%}


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