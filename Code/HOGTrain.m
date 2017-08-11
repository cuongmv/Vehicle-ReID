function [ predict_label_L, accuracy_L, dec_values_L ] = HOGTrain(excludeFileNo,strPathToSaveResult)
%HOGTrain Huan luyen su dung HOG

tic;
global strPathData;
global strPathWorkingData;

%Get number of vector from the file "Element.txt"
fElement=fopen(strcat(strPathWorkingData,'HOGElement.txt'),'r');
intElementArr = textscan(fElement, '%u16');
fclose(fElement);

trainData=[]; %Initialize the trainData matrix
trainLabel=[]; %Initialize the trainLabel matrix 
testData=[];%Initialize the testData matrix
groundTruthLabel=[];%Initialize the groundTruthLabel matrix

for i=1:5
    %Number of color histogram concatenation vector of the ith HOG file
    numOfElemens=intElementArr{1,1}(i);

    %Ten file HOG*.mat thu i
    fileHOGVector=strcat('HOG',num2str(i),'.mat');
    pathToFileHOG=strcat(strPathWorkingData,fileHOGVector);
    fHist=fopen(pathToFileHOG,'r');
       
        
    %Doc xong, chuyen vi de thu duoc dung format HOG Histogram
    %Luu y: chieu dai cua HOG concatenation vector là 3564 phan  tu 
    HOGArr=(fread(fHist,[3564, numOfElemens],'single=>double'))';
       
    %Normalize du lieu
    maxValue = max(max(HOGArr));
    HOGArr=HOGArr/maxValue;
    
    fclose(fHist);

    fileLabel=strcat('Label',num2str(i),'.mat');
    pathToFileLabel=strcat(strPathWorkingData,fileLabel);
    fLabel=fopen(pathToFileLabel,'r');
    labelArr= fread(fLabel,[numOfElemens, 1],'uint8=>double');
    fclose(fLabel);
    
     %Chia thanh 2 tap Train va Test de chuan bi vao giai doan Training
    if (i== excludeFileNo)
        testData=HOGArr;
        groundTruthLabel=labelArr;
    else
        trainData = [trainData; HOGArr];
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
save(strcat(strPathToSaveResult,'\model_testfile_',num2str(excludeFileNo),'.mat'),'groundTruthLabel','testData','model');
 fprintf('\n Training phase with test file no %i done! Elapsed time is %f. \n',excludeFileNo, toc);
tic;
%[predict_label_L, accuracy_L, dec_values_L] = svmpredict(groundTruthLabel, testData, model);
[predict_label_L, accuracy_L, dec_values_L] = predict(groundTruthLabel, sparse(testData), model);

save(strcat(strPathToSaveResult,'\result_testfile_',num2str(excludeFileNo),'.mat'), 'predict_label_L', 'accuracy_L','dec_values_L');
fprintf('\n Prediction done! Elapsed time is %f\n', toc);

end

