function [ HOG_Vector,hogVisualization ] = FeatureExtract_HOG(imgFileName)
%FeatureExtract_HistColor TRich chon dac trung HOG cua anh trong
%imgFile
%   
% Input: A image RGB img file name
% Output: HOG vector cv 1449 values
img=imread(imgFileName{1});
h=26;%Chieu cao cua window
w=26; %Chieu rong cua windows
% x=0.5; %Muc do overlapt theo truc ngang (theo cot)
% y=0.5; %Muc do overlapt theo truc dung (theo dong)
nbin=9; %so bin
[HOG_Vector,hogVisualization] = extractHOGFeatures(img,'CellSize',[h w],'BlockSize',[2 2], 'NumBins',nbin);
end

