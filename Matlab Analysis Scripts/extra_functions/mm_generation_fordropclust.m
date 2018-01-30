%recovered matrices are for new pipeline

load('r11_sr100.mat')
Xrec(Xrec<0)=0;

cv2=var(Xrec)./mean(Xrec).^2;
[values,indices]=sort(cv2,'descend');
Xrec_1000cols=Xrec(:,indices(1:1000));
%Xrec_1000cols=log2(1+Xrec_1000cols);
mmwrite('whole_matrix_newpipe_withoutlog_r11',Xrec_1000cols)

load('r14_sr100.mat')
Xrec(Xrec<0)=0;

cv2=var(Xrec)./mean(Xrec).^2;
[values,indices]=sort(cv2,'descend');
Xrec_1000cols=Xrec(:,indices(1:1000));
%Xrec_1000cols=log2(1+Xrec_1000cols);
mmwrite('whole_matrix_newpipe_withoutlog_r14',Xrec_1000cols)



load('r11_sr100.mat')
Xrec(Xrec<0)=0;

cv2=var(Xrec)./mean(Xrec).^2;
[values,indices]=sort(cv2,'descend');
Xrec_1000cols=Xrec(:,indices(1:1000));
Xrec_1000cols=log2(1+Xrec_1000cols);
mmwrite('whole_matrix_newpipe_withlog_r11',Xrec_1000cols)

load('r14_sr100.mat')
Xrec(Xrec<0)=0;

cv2=var(Xrec)./mean(Xrec).^2;
[values,indices]=sort(cv2,'descend');
Xrec_1000cols=Xrec(:,indices(1:1000));
Xrec_1000cols=log2(1+Xrec_1000cols);
mmwrite('whole_matrix_newpipe_withlog_r14',Xrec_1000cols)

