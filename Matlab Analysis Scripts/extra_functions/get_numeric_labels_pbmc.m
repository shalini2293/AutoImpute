function [ actual_labels ] = get_numeric_labels_pbmc(  )
%GET_NUMERIC_LABELS_JURKAT Summary of this function goes here
%   Detailed explanation goes here

fid=fopen('data/fully_proessed_data/processed_data_pbmc/68kdata/true_labels.csv');
gt=textscan(fid,'%s','HeaderLines',1,'Delimiter',',');
gt_labels=gt{1};
%addpath('extra_functions')
keySet =   { 'CD14+ Monocyte','CD19+ B','CD34+','CD4+ T Helper2', 'CD4+/CD25 T Reg','CD4+/CD45RA+/CD25- Naive T','CD4+/CD45RO+ Memory','CD56+ NK','CD8+ Cytotoxic T','CD8+/CD45RA+ Naive Cytotoxic','Dendritic'};
valueSet = [1,2,3,4,5,6,7,8,9,10,11];
mapi=containers.Map(keySet,valueSet); %access labels using map(gt{i})
actual_labels=[];
for i=1:length(gt_labels)
    actual_labels=[actual_labels;mapi(gt_labels{i})];
end
end

