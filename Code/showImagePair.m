function [ output_args ] = showImagePair(filePairOfImage,seqno )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%close all;
global strPathData;

pos=seqno;

figure;
for k = 1:2
    h(k) = subplot(2,1,k);
end

f=fopen(filePairOfImage,'r');
cellArrList = textscan(f,'%s %s %s');

showPair(pos);

% Create push button
    btn = uicontrol('Style', 'pushbutton', 'String', 'Next',...
        'Position', [100 10 60 20],...
        'Callback', '@nextPair()');  

fclose(f);
function showPair(sqo)
        %Hienthi anh camera A
    strPath=cellArrList{1,1}{sqo};
    strPath=strcat(strPathData,strPath);
    [img,map] = imread(strPath);
    subplot(h(1));
    imshow(img,map);

    mTextBoxA = uicontrol('style','text');
    set(mTextBoxA,'Position',[30 220 300 20]);
    set(mTextBoxA,'String',strPath);

    %Hienthi anh camera B
    strPath=cellArrList{1,2}{sqo};
    strPath=strcat(strPathData,strPath);
    [img,map] = imread(strPath);
    subplot(h(2));
    imshow(img,map);

    strAnnotation=cellArrList{1,3}{sqo};
    mTextBoxB = uicontrol('style','text');
    set(mTextBoxB,'Position',[30 30 300 20]);
    set(mTextBoxB,'String',strcat(strPath,' :',strAnnotation));
end

function nextPair()
pos=pos+1;
pos
showPair(pos);
end
end

