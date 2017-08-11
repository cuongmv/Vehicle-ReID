function [ listData ] = createListData( fileName )
%{ 
Step 01:    Create list data from file 'Train.lst' 
            and save file 'ListData.mat'
%}
%% read Train.lst, write filePath IA,IB, label in ListData.mat
    %fileName = 'Train.lst';
    index = 0;
    listData = [];
    fid = fopen(fileName,'r')
    if fid < 0
        fprintf('error opening file\n');
    else      
        while ~feof(fid)
            line = fgets(fid); % read line by line            
            C = strsplit(line,' ');            
            filePath01 = strjoin(C(1));
            filePath02 = strjoin(C(2));
            flag = strjoin(C(3)); 
            flag = flag(1:end-2);
            if strcmp('-1', flag) % same flag = 1, not same flag = 0
                flag = '0';
            end
            index = index + 1;
            listData(index).path01 = filePath01;
            listData(index).path02 = filePath02;
            listData(index).label = flag;            
        end
    end  
    fclose(fid);
end

