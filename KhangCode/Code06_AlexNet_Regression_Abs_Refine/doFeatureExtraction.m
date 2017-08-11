function [ features, labels ] = doFeatureExtraction( listData )
%    features(nDimVecto x nImage)
    %% Load pre-trained AlexNet
    net = alexnet();
    %% Use activations on the last fully connected layer ('fc7') with the image data
    layer = 'fc7';
    %%
    numImages = length(listData);
    labels = [];
    features = zeros(12288,numImages); % 4096x3
    for i = 1: numImages
        fprintf("\n %d/%d",i,numImages);
        strFile01 = listData(i).path01;       
        strFile02  = listData(i).path02;   
      
        featureIA = doFeatureExtractionImage(net, layer, strFile01);  
        featureIB = doFeatureExtractionImage(net, layer, strFile02);
        featureAbs = abs(featureIA - featureIB);
        
        feature = [featureIA featureIB featureAbs];   
        labels = [labels str2num(listData(i).label)]; 
        features(:,i) = feature';
        
    end
end
