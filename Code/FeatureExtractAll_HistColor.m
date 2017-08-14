function [numOfBytes,intSizeOfList]=FeatureExtractAll_HistColor( fileTrainOrTest, fileColorHist, fileLabel,flag )
%FeatureExtractAll_HistColor: Doc fileTrainOrTest va extract vector dac trung cho
%moi dong cua fileTrainOrTest, ket qua ghi xuong file fileColorHist (binary
%format), ngoai ra, cung tao ra fileLabel chua annotation
%flag=1: Train
%flag=0: Test
% Tra ve: mumOfBytes: Tong so byte ghi xuong
% intSizeofList: so dong (hoac so vector,  moi vector co chieu dai 4752 phan tu 1 byte)
%Thuat toan:
%   Voi moi dong d cua fileTrainOrTest
%        clvA=Tinh Vector color histogram cua thanh phan thu 1
%        clvB=Tinh Vector color histogram cua thanh phan thu 2
%        clvC=clvA-clvB
%        ghi [clvA, clvB, clvC] xuong fileColorHist
tic;
global strPathData;
global strPathWorkingData;


%Doc fileTrain
[fileImgArrayA, fileImgArrayB, annotationArray]=importfileTrain(fileTrainOrTest);
%Tao file Label
fLabel= fopen(fileLabel,'w');
fwrite(fLabel,annotationArray,'int8');
fclose(fLabel);
%intSizeOfList: so dong cua fileTrain
intSizeOfList=size(fileImgArrayA,1);
%fHist: file Color Histtogram Vector
fHist = fopen(fileColorHist,'w');
numBytes=0;
for i=1:intSizeOfList
    %Lay duong dan den anh cua camera A va trich chon vector dac trung clvA
    strPathA=strcat(strPathData,fileImgArrayA(i));
    clvA=uint32(FeatureExtract_HistColor(strPathA));
    
    %Lay duong dan den anh cua camera B va trich chon vector dac trung clvB
    strPathB=strcat(strPathData,fileImgArrayB(i));
    clvB=uint32(FeatureExtract_HistColor(strPathB));
    
    %Vector clvC= clvA-clvB
    clvC = abs(clvA-clvB);
  
    %Ghi xuong file, ket hop dem so byte ghi xuong, luu trong numBytes
        numBytes=numBytes+fwrite(fHist,[clvA clvB clvC],'uint16');
end
fclose(fHist);
numOfBytes=numBytes;

%Tao file Element.txt luu trong strPathData
if flag==1 
    fElement= fopen(strcat(strPathWorkingData,'ElementTrain.txt'),'w');
else
    fElement= fopen(strcat(strPathWorkingData,'ElementTest.txt'),'w');
end;
fprintf(fElement,'%u',intSizeOfList);
fclose(fElement);
toc;
end

