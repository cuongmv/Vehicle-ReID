function [ mAP,tp,fp ] = doEvaluation( labelPredict, labelGT )
    
    nResult = (labelPredict == labelGT');    
    tp = sum(nResult);  
    fp = length(nResult)- tp;
    fprintf('\nNumber of true positive: %d', tp);
    fprintf('\nNumber of false positive: %d', fp);
    fprintf("\n Ket thuc");
    mAP = tp / (tp + fp);

end

