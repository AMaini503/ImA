%GIST feature extraction for use in bag of words 
%run vl_setup 
%--Abhijeet Kumar---%

function [features , featuresMetrics]=GistExtraction(img)
    rows=256;
    columns=256;

    param.imageSize = [rows columns]; % it works also with non-square images
    param.orientationsPerScale = [8 8 8 8];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;
    
    [features, param] = LMgist(img, '', param);

    %get FeaturMetrics describing importance of a feature over another for this
    %image here used variance but other things could be used
    featuresMetrics=var(double(features),0,2);
