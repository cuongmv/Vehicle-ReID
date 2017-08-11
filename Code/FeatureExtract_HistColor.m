function [ colorHistVector ] = FeatureExtract_HistColor( imgFileName)
%FeatureExtract_HistColor TRich chon dac trung Histogram cua anh trong
%imgFile
%   
% Input: A image RGB img file
% Output: Color histogram vector cv 1548 values

img=imread(imgFileName{1});
h=52;
w=52;
x=0.5;
y=0.5;
nbin=16;
cellarr=ImagePartition(img,h,w,x,y);
clv=[];
for i=1:size(cellarr,1)
    for j=1:size(cellarr,2)
        red_hist=imhist(cellarr{i,j,1},nbin);
        green_hist=imhist(cellarr{i,j,2},nbin);
        blue_hist=imhist(cellarr{i,j,3},nbin);
        clv = [clv,red_hist',green_hist',blue_hist'];
    end
    
end
colorHistVector=clv;
end

