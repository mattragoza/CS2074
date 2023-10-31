function [accuracy] = compute_accuracy(predictions,labels)
    accuracy = mean(predictions == labels);
end