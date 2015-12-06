%GIST feature extraction for use in bag of words 
%run vl_setup 
%--Abhijeet Kumar---%

function [features , featuresMetrics]=HogExtraction(img)
    
    features = extractHOGFeatures(img);
    
    %get FeaturMetrics describing importance of a feature over another for this
    %image here used variance but other things could be used
    featuresMetrics=var(double(features),0,2);
