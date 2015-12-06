% BRISK feature extraction for use in bag of words 
%--Abhijeet Kumar---%

function [descriptor , featuresMetrics]=BriskExtraction(img)

%number of frames needs to be same in all images
required_frames=200;

%extract Brisk frames and features
grayImg=rgb2gray(img);
multiscaleBriskPoints=detectBRISKFeatures(grayImg);
features=extractFeatures(grayImg,multiscaleBriskPoints);

number_points=size(features.Features , 1);

features;
%extract random frames from each image
if size(features.Features) < required_frames
    descriptor=double(features.Features(:,:));
    descriptor(required_frames,64)=0; 
else
    descriptor=double(features.Features(randperm(number_points,required_frames),:));
end  

%get FeaturMetrics describing importance of a feature over another for this
%image here used variance but other things could be used
featuresMetrics=var(double(descriptor),0,2);
