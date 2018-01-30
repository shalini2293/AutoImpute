function [ output_args ] = imputation_gridsearch( dataset,nlayers,ranks, diff     ,y,M,dataX )
%IMPUTATION_GRIDSEARCH Summary of this function goes here
%   Detailed explanation goes here

if nlayers==3
        r1=ranks(1);  r2=ranks(2);  r3=ranks(3);
        
        for i=r3:diff:r2
            [Xrec ] = MF_MC_3layer(y,M,size(dataX),[r1 r2 i],   dataX);
            name=['RecMatrices/3Layer/RecMatrices_' dataset '/RecMatrix_3L_r=' num2str(r1) ',' num2str(r2) ',' num2str(i) '.mat']
            save(name,'Xrec')
        end
        
end
    

end

