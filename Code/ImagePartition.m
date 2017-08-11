function [cellarrB]=ImagePartition(A,h, w, x, y )
% A co kich thuoc M,N
%A=[1:12;13:24;25:36;37:48; 49:60; 61:72];
% Chia A thanh cac cua so con co kich thuoc h,w
% Muc do overlapt: x% theo cot, y% theo dong
% Luu ket qua tai cellarrB
% i la bien chay theo phuong dong, j la bien chay theo phuong cot

M=size(A,1);
N=size(A,2);
P=size(A,3);
delta_h=h*x; %Do dich chuyen theo dong
delta_w=w*y; %Do dich chuyen theo cot
cellarrB=cell((ceil(M/delta_w) -1),(ceil(N/delta_h) - 1),P);
 for i=1:size(cellarrB,1)
    for j=1:size(cellarrB,2)
        start_i=(i-1)*delta_h + 1;
        end_i=start_i+ h - 1 ;
        start_j=(j-1)*delta_w + 1;
        end_j=start_j+ w - 1 ;
        cellarrB{i,j,1}=A(start_i:end_i, start_j:end_j, 1);
        cellarrB{i,j,2}=A(start_i:end_i, start_j:end_j, 2);
        cellarrB{i,j,3}=A(start_i:end_i, start_j:end_j, 3);
        %cellarrB{1,1}=A(1:2,1:2);
    end
 end
% celldisp(cellarrB);
end