%surf feature extraction for use in bag of words 
%--Abhijeet Kumar---%
function [features , featuresMetrics]=SurfExtraction(img)

%extract surf frames and features
grayImg=rgb2gray(img);
multiscaleSURFPoints=detectSURFFeatures(grayImg);
features=extractFeatures(grayImg,multiscaleSURFPoints);

%get FeaturMetrics describing importance of a feature over another for this
%image here used variance but other things could be used
featuresMetrics=var(double(features),0,2);
