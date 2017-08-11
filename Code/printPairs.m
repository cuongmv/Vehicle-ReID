function printPairs(nFrom, nTo)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

f=fopen('Train.lst','r');
cellArrList = textscan(f,'%s %s %s');
fclose(f);

nFrom = 1;
nTo = 5;
fOut=fopen('OutPair1.htm','wt');
for seqno=nFrom:nTo
    %Hienthi anh camera A
    strPathA=cellArrList{1,1}{seqno};

    strPathA = strrep(strPathA, '\', '/');
    
    %Hienthi anh camera B
    strPathB=cellArrList{1,2}{seqno};
    strPathB = strrep(strPathB, '\', '/');
    
    strAnnotation=cellArrList{1,3}{seqno};

    strDir = ''; % 'C:\Users\Cuong Mai\Documents\Data';
    strOutput = sprintf('<P>[%d]. <IMG SRC="%s" ALT="%s"> vs <IMG SRC="%s" ALT="%s"> - [%d]', seqno, strPathA, strPathA, strPathB, strPathB, strAnnotation);

    fprintf(fOut, '%s\n', strOutput);

end

fclose(fOut);


    
end

