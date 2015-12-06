%for this to work u need to download all the data_generated on test case on your system for now
%inputs 
%img :image which needs to be calssified

%feature_descriptor and vocab size are used for now and will be removed in the later version
%feature_descriptor : Sift Surf Brisk Hog Gist (caution case sensitive)
%vocab_size : only meaningful in the case of sift surf brisk (allowed values [500 1000 1500 2000 2500 3000 3500 4000 4500 5000])

%outputs 
% knnx : x or lesser labels which are x nearest neighbors of the given image  using knn approach
% svm : 1 label indicating classified image  with svm approach

function [knn1,knn3,knn5,svm]=classify_image(img,feature_descriptor,vocab_size)

if strcmp(feature_descriptor,'Gist') OR  strcmp(feature_descriptor,'Hog')
    vocab_size=28;
end

knn3=[];
knn5=[];
%root_dir = loaction where data_generated folder is located 
root_dir='C:\Users\Abhijeet\Documents\MATLAB\cvit_summer_project_2015\phase 1\codebase\data_generated\';
filename=strcat(root_dir,'core_data\',feature_descriptor,'\data_',int2str(vocab_size),'_',feature_descriptor,'_1');

%load the required variables from already generated data (will be changed in the future)
load(filename,'categoryClassifierKNN','categoryClassifierSVM','bag');

%getting all the categories
labels=categoryClassifierKNN.ClassNames;

%resizing the input image to a size of [256 256]
img_resized=imresizecrop(img,[256 256]);

%extract  the required image features
img_encoded=encode(bag,img_resized);

%KNN1
 categoryClassifierKNN.NumNeighbors=1;
[labelIdx, scores_knn1] = predict(categoryClassifierKNN,double(img_encoded));
knn1=labelIdx;

%KNN3
 categoryClassifierKNN.NumNeighbors=3;
[labelIdx, scores_knn3] = predict(categoryClassifierKNN,double(img_encoded));
for i=1:size(scores_knn3,2)
    if scores_knn3(1,i) > 0.0
        knn3=[knn3 ; labels(i,1) ];
    end
end

%KNN5
 categoryClassifierKNN.NumNeighbors=5;
[labelIdx, scores_knn5] = predict(categoryClassifierKNN,double(img_encoded));
for i=1:size(scores_knn5,2)
    if scores_knn5(1,i) > 0.0
        knn5=[knn5 ; labels(i,1) ];
    end
end

%knn5=labelIdx;

%SVM
[labelIdx, scores_svm] = predict(categoryClassifierSVM,img);
svm=labels(labelIdx); 

% converting to json 
arr={knn1,knn3,knn5,svm};
s=[];
s{1}=strcat(' "knn1" : "',knn1, '" ');
s{2}=strcat(' "knn3" :[ ');
s{3}=strcat(' "knn5" :[ ');
for j=2:3
    w=arr{j}
    for i=1:size(w,1)-1
        s{j}=strcat(s{j},'"', w(i), '", ');
    end
    s{j}=strcat(s{j},'"', w(size(w,1)), '" ');
    s{j}=strcat(s{j},']');
end
s{4}=strcat('"svm" : "',svm, '" ');

% s1=strcat(' "knn1" : "',knn1, '" ');
% 
% s2=strcat(' "knn3" :[ ');
% for i=1:size(knn3,1)-1
%     s2=strcat(s2,'"', knn3(i), '", ');
% end
% s2=strcat(s2,'"', knn3(size(knn3,1)), '" ');
% s2=strcat(s2,']');
% 
% s3=strcat(' "knn5" :[ ');
% for i=1:size(knn5,1)-1
%     s3=strcat(s3,'"', knn5(i), '", ');
% end
% s3=strcat(s3,'"', knn5(size(knn5,1)), '" ');
% s3=strcat(s3,']');
% 
% s4=strcat('"svm" : "',svm, '" ');
% 
%s=strcat('{ "data": {' ,s1, ',' ,s2, ',' ,s3, ',' ,s4, '} }' );

str=strcat('{ "data": {' ,s{1}, ',' ,s{2}, ',' ,s{3}, ',' ,s{4}, '} }' );
str=char(str);

fid = fopen('data.json','a');
    fprintf(fid,'%s\n',str);
fclose(fid);
