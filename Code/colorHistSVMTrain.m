function [ predict_label_L, accuracy_L, dec_values_L ] = colorHistSVMTrain(excludeFileNo, strPathToSaveResult)
%ColorHistSVMTrain Huan luyen SVM
% Tra ve strucModel 


tic;

global strPathData;
global strPathWorkingData;


%Get number of vector from the file "Element.txt"
fElement=fopen(strcat(strPathData,'Element.txt'),'r');
intElementArr = textscan(fElement, '%u16');
fclose(fElement);

trainData=[]; %Initialize the trainData matrix
trainLabel=[]; %Initialize the trainLabel matrix 
testData=[];%Initialize the testData matrix
groundTruthLabel=[];%Initialize the groundTruthLabel matrix

for i=1:5
    %Number of color histogram concatenation vector of the ith ColorHist file 
    numOfElemens=intElementArr{1,1}(i);

    %Ten file ColorHist*.mat thu i
    fileColorHistVector=strcat('ColorHist',num2str(i),'.mat');
    pathTofileColorHistVector=strcat(strPathWorkingData,fileColorHistVector);
    fHist=fopen(pathTofileColorHistVector,'r');
    
    %Doc xong, chuyen vi de thu duoc dung format Color Histogram
    %Luu y: chieu dai cua color histogram concatenation vector là 4752 phan  tu 
    colorHistVectorArr=(fread(fHist,[4752, numOfElemens],'uint16=>double'))';
        
    %Normalize du lieu
    maxValue = max(max(colorHistVectorArr));
    colorHistVectorArr=colorHistVectorArr/maxValue;
    fclose(fHist);
    
    %Doc file Label vao labelArr (la ma tran cot)
    fileLabel=strcat('Label',num2str(i),'.mat');
    fullPathToFileLabel=strcat(strPathWorkingData,fileLabel);
    fLabel=fopen(fullPathToFileLabel,'r');
    labelArr= fread(fLabel,[numOfElemens, 1],'uint8=>double');
    fclose(fLabel);
    
    %Chia thanh 2 tap Train va Test de chuan bi vao giai doan Training
    if (i== excludeFileNo)
        testData=colorHistVectorArr;
        groundTruthLabel=labelArr;
        intNumOfTestElement=numOfElemens;
    else
        trainData = [trainData; colorHistVectorArr];
        trainLabel= [trainLabel; labelArr];

    end
    fprintf('\n i=%u ',i);
end
 fprintf('\n Training phase with test file no %i running ... \n',excludeFileNo);
%SVMStruct = svmtrain(trainData,trainLabel,'autoscale','kernel_function','linear');
% strOptions='-s 0 -t 0 -b 1';
%fprintf('\n Options: %s\n: Classification, Linear, Probability.',strOptions);
% model = svmtrain(trainLabel,trainData,strOptions);
strOptions='-s 6';
fprintf('\n Options: %s\n: Classification, Linear, Probability.',strOptions);
model = train(trainLabel,sparse(trainData),strOptions);
save(strcat(strPathToSaveResult,'model_testfile_',num2str(excludeFileNo),'.mat'),'groundTruthLabel','testData','model');
 fprintf('\n Training phase with test file no %i done! Elapsed time is %f. \n',excludeFileNo, toc);
tic;
%[predict_label_L, accuracy_L, dec_values_L] = svmpredict(groundTruthLabel, testData, model);
[predict_label_L, accuracy_L, dec_values_L] = predict(groundTruthLabel, sparse(testData), model);

%Ghi cac cap sai va cap dung xuong thanh file mismatch.lst, match.lst
strMismatch=strcat('Mismatch',num2str(excludeFileNo),'.lst');
strMatch=strcat('Match',num2str(excludeFileNo),'.lst');
strMismatch=strcat(strPathWorkingData,strMismatch);
strMatch=strcat(strPathWorkingData,strMatch);
fMismatch=fopen(strMismatch,'w');
fMatch=fopen(strMatch,'w');
%Cap nhat lai file Train*.lst
strFileTrain=strcat('Train',num2str(excludeFileNo),'.lst');
strFileTrain=strcat(strPathWorkingData,strFileTrain);
fFileTrainID=fopen(strFileTrain,'r');

strFileTrainColor=strcat('TrainColor',num2str(excludeFileNo),'.lst');
strFileTrainColor=strcat(strPathWorkingData,strFileTrainColor);
fFileTrainID=fopen(strFileTrainColor,'w');

%viet tiep ... doc va ghi file Train*.lst

for j=1:intNumOfTestElement
    strDataTrainColor=fgetl(fFileTrainID);
    if predict_label_L(j)== groundTruthLabel(j)
       fprintf(fMatch,'%s\n',num2str(j));
       strDataTrainColor=strcat(strDataTrainColor,'' ,'1');
    else
       fprintf(fMismatch,'%s\n',num2str(j));
       strDataTrainColor=strcat(strDataTrainColor,'' ,'-1');
    end;
    fprintf(fFileTrainID,'%s\n',strDataTrainColor);
end;
fclose(fMismatch);
fclose(fMatch);
fclose(fFileTrainID);

save(strcat(strPathToSaveResult,'result_testfile_',num2str(excludeFileNo),'.mat'), 'predict_label_L', 'accuracy_L','dec_values_L');
fprintf('\n Prediction done! Elapsed time is %f\n', toc);

end

