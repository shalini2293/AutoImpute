function [ labels  ] = get_numeric_labels_mouseBrain(  )
%GET_NUMERIC_LABELS_MOUSEBRAIN Summary of this function goes here
%   Detailed explanation goes here


fid=fopen('data/data_RAW/data_mouseBrain/labels_sorted.csv');
gt=textscan(fid,'%s%s','Delimiter',',');
gt_labels=gt{1};
keySet =   { 'Astrocyte','Endothelial','Microglia','Myelinating Oligodendrocyte', 'Neurons','Newly formed Oligodendrocyte', 'OPC','purple','unannotated'};
valueSet = [1,2,3,4,5,6,7,8,9];
mapi=containers.Map(keySet,valueSet); %access labels using map(gt{i})
labels=[];
for i=1:length(gt_labels)
labels=[labels;mapi(gt_labels{i})];
end

labels(find(labels==9))=[];

end

