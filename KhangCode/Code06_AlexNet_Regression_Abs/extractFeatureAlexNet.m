function [features] = extractFeatureAlexNet(net,I,layer)
     I = imresize(I, [227 227]);
     features = activations(net,I,layer);
end