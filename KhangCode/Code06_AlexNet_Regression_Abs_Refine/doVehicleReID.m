function [ mAP ] = doVehicleReID( listTrain, listTest)
   
    [featureTrain, labelTrain] = doFeatureExtraction(listTrain);
    
    Model = doLearningClassifier(featureTrain,labelTrain);
    
    [labelPredict, labelGT] = doPrediction(Model,listTest);
    
    [mAP, tp, fp]= doEvaluation(labelPredict, labelGT);
    
end

