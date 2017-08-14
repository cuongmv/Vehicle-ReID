function [ output_args ] = combineFile( input_args )
%combineFile: Join 5 file Train*.lst thanh 1 file train.txt,
% va join 5 file Test*.lst thanh 1 file Test.txt,

global strPathWorkingData;
old_folder=cd(strPathWorkingData); 
system('copy Train1.lst + Train2.lst+Train3.lst +Train4.lst +Train5.lst Train.txt /Y'); 
system('copy Test1.lst + Test2.lst +Test3.lst +Test4.lst +Test5.lst Test.txt /Y');
cd(old_folder);
clc;
% fileTrainName=strcat(strPathWorkingData, 'Train.txt');
% fileTestName=strcat(strPathWorkingData, 'Test.txt');
% 
% fileTrainID = fopen(fileTrainName,'a');
% fileTestID = fopen(fileTestName,'a');
% for i=1:5
%     fTrainName= strcat(strPathWorkingData,'Train',num2str(i),'.lst');
%     [fileImgArrayA, fileImgArrayB, annotationArray]=importfileTrain(fTrainName);
%     fwrite(fileTrainID,)
% 
% end;

fprintf('\r\nThe training file Train.txt and testing file Test.txt were created successfully at %s.\r\n',strPathWorkingData);
end

