function [ labelPredict, labelGT ] = doPrediction( model, listData )

      [featureTest, labelGT] = doFeatureExtraction(listData);
       labelPredict = predict(model, featureTest');
end

