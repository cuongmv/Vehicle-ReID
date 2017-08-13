function generateTrainAndTest(fileNameGroundTruth,num)
%generateTrainAndTest: generate train list and test list (train.txt, test.txt)
%	Train.txt: Chua positive file pair, và negative file pair duoc dùng cho giai doan training.
%	Test.txt: Chua positive file pair, và negative file pair duoc dùng cho giai doan testing.
%	Cot 1: duong dan tu folder Dataset\VehicleReID den mot file .jpg trong folder *A
%	Cot 2: duong dan tu folder Dataset\VehicleReID den mot file .jpg trong folder *B
%	Cot 3: Annotation, chuaa giá tri 1 neu là positive pair, -1 neu là negative pair


global strPathData;
global strPathWorkingData;

%Tam thoi gan, se tinh lai
p=6; %so luong cac cap positive ung voi 1 dong lay tu ground_truth_shot_*.csv (hoac gt_CellArray)
q=2; %q:1=ty le cap anh negative:positive
r=2; %r:1= ty le train: test
%Cac hang so tren nghia la: ung voi 1 dong trong ground_truth_shot_*.csv,
%co p=6 cap positive va 12 (=p*q) cap negative
%Tuy nhien 6 cap positve duoc dat o Train (4) va Test (2); 
%Tuong tu 12 cap negative duoc dat o Train (8) va Test (4)

%1.Doc du lieu tu file ground_truth_shot_*.csv vao gt_CellArray (Cell array)
% file nay chua 2 cot: VD tai 1 dong chua 1A/10_2377_representative.png	 "1B/2_1970_representative.png"
% nghia la cho biet 2 file tren la 1 cap positive
gt_CellArray=importfileCSV(fileNameGroundTruth);

%2. Voi moi dong d doc duoc, tim va phat sinh ngau nhien p positive pair, q
%negative pair
%2a. Truoc tien, loai bo dau "" trong gt_CellArray
for i=1:size(gt_CellArray,1)
   for j=1: size(gt_CellArray,2)
        gt_CellArray{i,j}=strrep(gt_CellArray{i,j},'"',''); % Bo dau ""
        gt_CellArray{i,j}=strrep(gt_CellArray{i,j},'/','\');
   end
end
seqno=num2str(num);
fileTrainName=strcat(strPathWorkingData, 'Train',seqno,'.lst');
fileTestName=strcat(strPathWorkingData, 'Test',seqno,'.lst');

fileTrainID = fopen(fileTrainName,'w');
fileTestID = fopen(fileTestName,'w');

%2b. Voi moi phan tu cua cot 1 cua gt_CellArray (camera A)
for i=1:size(gt_CellArray,1);
% Doc cac dong cua cung 1 vehicle tuong ung voi vehicle i tu cameraA 
% cac dong nay duoc dat nam trong thu muc strDirA
    begin_part_A=strsplit(gt_CellArray{i,1},'_'); %Tach lay phan dau
    strA=strcat(strPathData,begin_part_A{1,1},'_*.png');%xay dung duong dan 
    strA=strrep(strA,'''','');% Go bo ky tu ' 
    strDirA = dir(strA);
% Doc cac dong cua cung 1 vehicle tuong ung voi vehicle i tu cameraB 
% cac dong nay duoc dat nam trong thu muc strDirB
    begin_part_B=strsplit(gt_CellArray{i,2},'_');
    strB=strcat(strPathData,begin_part_B{1,1},'_*.png');
    strB=strrep(strB,'''','');
    strDirB = dir(strB);
    
% Phat sinh ngau nhien p positive pair va p*q negative pair
    for ii=1:p
        k=randi(length(strDirA)-2);
        fileA=strDirA(k).name;
        h=randi(length(strDirB)-2);
        fileB=strDirB(h).name;
        %Ghi xuong file Train va file Test.lst theo ty le r:1=2:1
        if ii <= p*r/(r+1)
            fprintf(fileTrainID,'%sA\\%s %sB\\%s 1\r\n',seqno, fileA,seqno,fileB);
        else
            fprintf(fileTestID,'%sA\\%s %sB\\%s 1\r\n',seqno, fileA,seqno,fileB);
        end;
        % Phat sinh ngau nhien q cap negative pair
        for jj=1:q
        %Lay 1 file khac tu Camera A
            kk=randi(length(strDirA)-2);
            if k==kk
                kk=randi(length(strDirA)-2);
            end
            fileAA=strDirA(kk).name;
            % Doc cac dong notsame_d_B khac vehicle voi d tu cameraB
            if i < size(gt_CellArray,1) %Lay anh j tu loat anh ke tiep i o cameraB, hy vong se khac loat i
                j=i+1;
            else
                j=1;
            end
            begin_part_C=strsplit(gt_CellArray{j,2},'_');
            strC=strcat(strPathData,begin_part_C{1,1},'_*.png');
            strC=strrep(strC,'''','');
            strDirC = dir(strC);

            hh=randi(length(strDirC)-2);
            fileC=strDirC(hh).name;
             %Ghi xuong file Train va file Test.lst theo ty le r:1=2:1
             if mod(ii*q+jj-q, r+1)~=0 % Xem giai thich o file GiaiThich-VitriIf-generateTrainAndTest.jpg
                fprintf(fileTrainID,'%sA\\%s %sB\\%s -1\r\n',seqno,fileAA, seqno,fileC);
             else
                 fprintf(fileTestID,'%sA\\%s %sB\\%s -1\r\n',seqno,fileAA, seqno,fileC);
             end;
        end
    end
    
end;
 fclose(fileTrainID);
 fclose(fileTestID);
end


