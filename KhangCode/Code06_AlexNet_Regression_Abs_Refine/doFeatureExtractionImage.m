function [ feature ] = doFeatureExtractionImage( net,layer,image )
    %% Read image
    IA = imread(image);
    %% Extract feature fc7
    feature = doFeatureExtractionAlexNet(net,layer, IA);
end

