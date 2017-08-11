function [ model ] = doLearningClassifier( feature, label )
%% input fitcsvm: vecto + label
% vecto: nImage x nDim
% label: nImage x nDim

    model = fitcsvm(feature', label'); 
end

