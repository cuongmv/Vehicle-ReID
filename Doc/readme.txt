1)Cac file moi phat trien
-GenerateTrainList.m
-importfileCSV.m
-[VarName1,VarName2,VarName3] = importfileTrain(filename, startRow, endRow)
VD: 
-showImagePair(fileTrain,seqno ): Show anh o fileTrain, so thu tu seqno
VD:showImagePair(Train1.lst,1001)

- [numOfBytes,intSizeOfList]=FeatureExtractAll_HistColor( fileTrain, fileColorHist )
VD [numBytes, row]=FeatureExtractAll_HistColor('Train4.lst','ColorHist4.mat');
-FeatureExtract_HistColor

2)Doan script sinh ra cac file Train*.lst
Truoc khi chay chuong trinh GenerateTrainList, nho xoa file Train.lst
----
strProject='C:\Projects\VehicleID\';
strData=strcat(strProject,'Data\');
for index=1:5
    fileNameGroundTruth= strcat(strData,'ground_truth_shot_',num2str(index),'.csv');
    GenerateTrainList(fileNameGroundTruth,num2str(index));
end;
---
3) Doan script sinh ra cac file ColorHist*.mat va Label*.mat
numBytes=[];
row=[];
for i=1:5
    fileTrain= strcat('Train',num2str(i),'.lst');
    fileColorHist= strcat('ColorHist',num2str(i),'.mat');
    fileLabel=strcat('Label',num2str(i),'.mat');
    [numBytes(i), row(i)]=FeatureExtractAll_HistColor(fileTrain,fileColorHist,fileLabel);
end;
--------------
Ket qua:
Thoi gian lan luot khi sinh ra cac file ColorHist1.mat -> ColorHist5.mat, Label1.mat -> Label5.mat
Elapsed time is 72.987357 seconds.
Elapsed time is 64.523675 seconds.
Elapsed time is 61.413701 seconds.
Elapsed time is 58.652289 seconds.
Elapsed time is 103.653828 seconds.
Kich thuoc file (bytes) va so dong vector lan luot trong cac file ColorHist*.mat la:
    Kich thuoc      So dong
    12,317,184        2,592
    10,863,072        2,286
    10,264,320        2,160
     9,836,640        2,070
    17,363,808        3,654
------------------------------------
Doan script sinh file HOG*.mat
numBytes=[];
row=[];
for i=1:5
    fileTrain= strcat('Train',num2str(i),'.lst');
    fileHOG= strcat('HOG',num2str(i),'.mat');
    [numBytes(i), row(i)]=FeatureExtractAll_HOG(fileTrain,fileHOG);
end
--------------
Ket qua:
Thoi gian lan luot khi sinh ra cac file HOG1.mat -> HOG5.mat
Elapsed time is 52.362209 seconds.
Elapsed time is 44.638853 seconds.
Elapsed time is 42.775153 seconds.
Elapsed time is 40.919109 seconds.
Elapsed time is 72.666922 seconds.

Kich thuoc file (bytes) va so dong vector lan luot la:
    Kich thuoc      So dong
    9,237,888        2,592
     8,147,304        2,286
     7,698,240        2,160
     7,377,480        2,070
    13,022,856        3,654
*************************************************************
4) [numOfBytes,intSizeOfList]=FeatureExtractAll_HOG( fileTrain, fileHOG )
%FeatureExtractAll_HOG: Doc fileTrain va extract vector dac trung HOG cho
%moi dong cua fileTrain, ket qua ghi xuong file fileHOG (binary
%format)
% Tra ve: mumOfBytes: Tong so byte ghi xuong
% intSizeofList: so dong (hoac so vector,  moi vector co chieu dai 4752 phan tu 1 byte)

numBytes=[];
row=[];
for i=1:5
    fileTrain= strcat('Train',num2str(i),'.lst');
    fileHOG= strcat('HOG',num2str(i),'.mat');
    %fileLabel=strcat('Label',num2str(i),'.mat');
    [numBytes(i), row(i)]=FeatureExtractAll_HOG(fileTrain,fileHOG);
end;
--------------
5) Doan code load va conbine ket qua chay
load('model_testfile_1.mat');
load('result_testfile_1.mat');
conbined=[dec_values_L, predict_label_L,groundTruthLabel];
 