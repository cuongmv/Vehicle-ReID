function methodAlexnet(Dataset)
    load(Dataset);
    load('ListData.mat');    
	%% Load pre-trained AlexNet
    net = alexnet();
    %% Use activations on the last fully connected layer ('fc7') with the image data 
    layer = 'fc7';
    numImages = length(idxTrain);
    dataTrain = zeros(12288,numImages);
    for i = 1: numImages
        fprintf("\n Thu tu: %d",i);

        strFile01 = listData(idxTrain(i)).path01;
        IA = imread(strFile01); 
        strFile02  = listData(idxTrain(i)).path02;
        IB = imread(strFile02);
        
        featureIA = extractFeatureAlexNet(net,IA,layer);  
        featureIB = extractFeatureAlexNet(net,IB,layer);
        featureAbs = abs(featureIA - featureIB);
        features = [featureIA featureIB featureAbs];         
        dataTrain(:,i) = features';
    end
	save('DataTrainSplit01.mat','dataTrain');
    %load('DataTrainSplit01.mat');
	Mdl = fitcsvm(dataTrain', lblTrain'); 
    save('ModelSplit01.mat','Mdl');
    %load('ModelSplit01.mat');
    %% predict
    numImages = length(idxTest);
    dataTest = zeros(12288,numImages);
    for i = 1: numImages
        fprintf("\n Thu tu: %d",i);

        strFile01 = listData(idxTest(i)).path01;
        IA = imread(strFile01); 
        strFile02  = listData(idxTest(i)).path02;
        IB = imread(strFile02);
        
        featureIA = extractFeatureAlexNet(net,IA,layer);  
        featureIB = extractFeatureAlexNet(net,IB,layer);
        featureAbs = abs(featureIA - featureIB);
        features = [featureIA featureIB featureAbs];
        dataTest(:,i)  =  features';
    end
	save('DataTestSplit01.mat','dataTest');    
    fprintf("\n Predict data test");
    lblResult = predict(Mdl, dataTest');    
    nResult = (lblResult == lblTest');    
    nCount = sum(nResult);  
    fprintf('\nNumber of true sample: %d', nCount);
    fprintf('\nNumber of false: %d', length(nResult)- nCount);
    fprintf("\n Ket thuc");
end