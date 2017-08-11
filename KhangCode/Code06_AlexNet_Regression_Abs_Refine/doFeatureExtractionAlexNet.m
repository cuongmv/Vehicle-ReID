function [features] = doFeatureExtractionAlexNet(net,layer,I)
     I = imresize(I, [227 227]);
     features = activations(net,I,layer);
end