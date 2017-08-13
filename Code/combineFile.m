function [ output_args ] = combineFile( input_args )
%combineFile: Join 5 file train*.lst thanh 1 file train.txt

global strPathWorkingData;
old_folder=cd(strPathWorkingData);
system('copy Train1.lst + Train2.lst +Train3.lst +Train4.lst +Train5.lst Train.txt /Y');
system('copy Test1.lst + Test2.lst +Test3.lst +Test4.lst +Test5.lst Test.txt /Y');

cd(old_folder);
clc;
fprintf('\r\nThe training file Train.txt and testing file Test.txt were created successfully at %s.\r\n',strPathWorkingData);
end

