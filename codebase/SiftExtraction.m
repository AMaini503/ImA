%sift feature extraction for use in bag of words 
%run vl_setup 
%--Abhijeet Kumar---%

function [features , featuresMetrics]=SiftExtraction(img)

%number of frames needs to be same in all images
required_frames=200;

%extract dift frames and descriptor using vl_sift
grayImg=rgb2gray(img);
[frames,descriptors]=vl_sift(single(grayImg));
number_points=size(descriptors,2);

% if number_points < 200
%     a=50000
%     number_points
% end

%extract random frames from each image if number of frames is less than
%required frame take all
if number_points < required_frames
    features=double(descriptors(:,:));
    features(128,required_frames)=0;
else
    features=double(descriptors(:,randperm(number_points,required_frames)));
end
features=features.';

%get FeaturMetrics describing importance of a feature over another for this
%image here used variance but other things could be used
featuresMetrics=var(double(features),0,2);
