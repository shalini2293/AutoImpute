
anno=get_numeric_labels_mouseBrain();
Pbmc_genepruned_median_normed=csvread('data/median_normalized_data/Pbmc_MedianNormalized.csv',1,0);
X=Pbmc_genepruned_median_normed;


figure;
ind=find(anno==1);%1/3 title('Density: Samples of label 16cell (preimplantation data)')

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
kde(struct('tran',1,'data',corr_vector))
corr_vector1=corr_vector


hold on;
load('data/best/best/saved_models_pbmc/pbmc_12000_3000.mat')
arr=double(reshape(arr,[68579,1000]));
X=arr;

A=X(ind,:);

pair_corr=corr(A')
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask)
save('densityPlotR/sample2.mat','corr_vector','-v6')
kde(struct('tran',1,'data',corr_vector))
corr_vector2=corr_vector

fs=14;
xl=xlabel('Pearson correlation')
yl=ylabel('Density')
leg=legend('No imputation','AutoImpute')%
leg.FontSize=fs
xl.FontSize=fs
yl.FontSize=fs

LEG=set(leg,'Location','northwest')
set(findall(gca, 'Type', 'Line'),'LineWidth',1.5);

ylim([0 200])
xlim([0 1.05])