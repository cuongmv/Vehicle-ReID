function  go(num)
%go: run the main program
%Parameter:
%num=1: Generate training/testing list (train.txt, test.txt) and storing them into $strPathProject\WorkingData
%num=2: Generate color histogram feature vector files (ColorHist*.mat,Label*.mat) and storing them into $strPathProject\WorkingData
%num=3: Train and predict with color histogram feature. The results are saved into $strPathProject\Color\
%num=4: View all the wrong pairs from the result of step 3
%num=5: Generate HOH feature vector files (HOG*.mat) with all the matching pairs from step 3, and storing them into $strPathProject\WorkingData
%num=6: Train and predict with HOG feature with data generated from step 5. The results are saved into $strPathProject\HOG\
%num=7: View all the matching pairs from the result of step 3

%num=4: Generate HOH feature vector files (HOG*.mat) and storing them into $strPathProject\WorkingData
%num=5: Train and predict with HOG feature. The results are saved into $strPathProject\HOG\

%Home project directory
global strPathProject; 

%Data from dataset
global strPathData;

%Working Data 
global strPathWorkingData;

%Results data
global strPathResults;

strPathProject='C:\Projects\Vehicle-ReID\';
strPathData=strcat('C:\Projects\Dataset\VehicleReID\');
strPathWorkingData=strcat(strPathProject,'WorkingData\');
strPathResults=strcat(strPathProject,'Results\');

if nargin > 0
switch num
    case 1 %Generating training list (train*.lst, train.txt) 
        for index=1:5
            fileNameGroundTruth= strcat(strPathData,'ground_truth_shot_',num2str(index),'.csv');
            generateTrainAndTest(fileNameGroundTruth,index);
        end;
        combineFile(); %Combine the Train*.lst(s) into the file Train.txt, Test*.lst into the file Test.txt
    case 2 %Generate color histogram feature vector files for training part
            fileTrain= strcat(strPathWorkingData,'Train.txt');
            fileColorHistForTrain= strcat(strPathWorkingData,'ColorHistForTrain.mat');
            fileLabelForTrain=strcat(strPathWorkingData,'LabelForTrain.mat');
            FeatureExtractAll_HistColor(fileTrain,fileColorHistForTrain,fileLabelForTrain,1);
            %Generate color histogram feature vector files for testing part
            fileTest= strcat(strPathWorkingData,'Test.txt');
            fileColorHistForTest= strcat(strPathWorkingData,'ColorHistForTest.mat');
            fileLabelForTest=strcat(strPathWorkingData,'LabelForTest.mat');
            FeatureExtractAll_HistColor(fileTest,fileColorHistForTest,fileLabelForTest,0);
        
    case 3 %Training with Color Histogram Feature
            strPathToSaveResult=strcat(strPathResults,'Color\');
            colorHistSVMTrain(strPathToSaveResult);
      
    case 4
%         strImg='Train2.lst';
%         intSeq=101;
%         strImg=strcat(strPathWorkingData,strImg);
%         showImagePair(strImg,intSeq);
        showPairOfImage();
    case 5
        for i=1:5
            fileTrain= strcat(strPathWorkingData,'Train',num2str(i),'.lst');
            fileHOG= strcat(strPathWorkingData,'HOG',num2str(i),'.mat');
            fileMatch= strcat(strPathWorkingData,'Match',num2str(i),'.lst');
            %fileLabel=strcat('Label',num2str(i),'.mat');
            FeatureExtractAll_HOG(fileTrain,fileHOG,fileMatch,i);
        end;
    case 6 %Training with HOG Feature
         for excludeFileNo=1:5;
            strPathToSaveResult=strcat(strPathResults,'HOG\L',num2str(excludeFileNo),'\');
            HOGTrain(excludeFileNo,strPathToSaveResult);
         end;
end;
end;
end

  %case 4 %Generate HOH feature vector files
%         for i=1:5
%             fileTrain= strcat(strPathWorkingData,'Train',num2str(i),'.lst');
%             fileHOG= strcat(strPathWorkingData,'HOG',num2str(i),'.mat');
%             %fileLabel=strcat('Label',num2str(i),'.mat');
%             FeatureExtractAll_HOG(fileTrain,fileHOG);
%         end;
%     case 5%Training with HOG Feature
%          for excludeFileNo=1:5;
%             strPathToSaveResult=strcat(strPathResults,'HOG\L',num2str(excludeFileNo),'\');
%             HOGTrain(excludeFileNo,strPathToSaveResult);
%          end;
