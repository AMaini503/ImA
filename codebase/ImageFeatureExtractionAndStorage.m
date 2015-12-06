%Bag Of Features using Computer Vision ToolBox & Matlab 2015b
%Feature Descriptor Method variable and Classifier KNN SVM(Multiclass)
%--Abbhinav Venkat--%
%--Abhijeet Kumar---%

%convert all the images in the data set to the size [256 256]
%careful :::: make a copy of the root directory as the images will be resized
% ImageFeatureExtractionAndStorage(root_directory,allcodeBook(j),all_methods{i});

% root_directory='C:\Users\Abhijeet\Documents\MATLAB\cvit_summer_project_2015\phase 1\dataset\';
% all_methods={'Sift','Brisk','Surf'};
% all_methods={'Gist','Hog'};
% %allCodeBook=[500,1000,1500,2000,2500,3000,3500,4000,4500,5000];
% allCodeBook=[28];
% allmethods_size=size(all_methods,2);
% allCodeBooks_size=size(allCodeBook,2);
% 
% for ee =1:allmethods_size
%     for qq=1:allCodeBooks_size

% method = Surf Sift Brisk Gist Hog  %Hog and Gist return a single feature
% vector per image hence codeBookSize is rather meaningless in these
function [bag , categoryClassifierKNN , categoryClassifierSVM] = ImageFeatureExtractionAndStorage(root_directory,codeBookSize,method)  %todo , featureType surf done sift .. hog  gist etc to be included in this model using bagOffeatures() // custom secriptor functions to de defined
codeBookSize=allCodeBook(qq);
method=all_methods{ee};
    X=[];
    Y=[];
    
    confMatrixKNN1_mean=[];
    confMatrixKNN2_mean=[];
    confMatrixKNN3_mean=[];
    p_KNN1_mean=[];
    r_KNN1_mean=[];
    p_KNN3_mean=[];
    r_KNN3_mean=[];
    p_KNN5_mean=[];
    r_KNN5_mean=[];
    
    confMatrixSVM_mean=[];
    p_SVM_mean=[];
    r_SVM_mean=[];
    
    %resize all images to size [256 256 3]
    root_dir=dir(root_directory);
    root_dir_size=size(root_dir,1);
    length_root_directory=size(root_directory);
    
    for j=3:root_dir_size
        child_dir=dir(strcat(root_directory,'\',root_dir(j).name,'\*.JPG'));
        child_dir_size=size(child_dir,1);
        for i=1:child_dir_size
            string=strcat(root_directory,root_dir(j).name,'\',child_dir(i).name);%'.JPG')
            a=imresize(imread(string),[256 256]);
            imwrite(a,string);
        end
    end


    %Set as directory where images are located
    setDir  = root_directory;
    imgSets = imageSet(setDir,'recursive');

    %keeping equal number of images for All type of categories (not using for now because number of images are still small in some categories) 
    %imgSetMin=min([imgSets.Count]);
    %imgFinalSet = partition(imgSets,imgSetMin,'randomize');


    for m=1:3
        %Partitioning into two sets 3 times for a better average calculations
        
        if m==1
            [trainingSet,testSet] = partition(imgSets,[0.66 0.33 ],'sequential');
        elseif m==2
            [testSet,trainingSet] = partition(imgSets,[0.33 0.66 ],'sequential');
        else 
            [trainingSet,testSet] = partition(imgSets,[0.66 0.33 ],'random');
        end

        %Creating Bag of Features for SURF inbuilt function
        %bag = bagOfFeatures(subSet1,'VocabularySize',codeBookSize);

        %Creating bag by defining our own feature extraction function
        extractionFnc=str2func(strcat(method,'Extraction'));
        bag= bagOfFeatures(trainingSet,'VocabularySize',codeBookSize,'CustomExtractor',extractionFnc,'StrongestFeatures',0.9,'Verbose',false);

    
        %Histogram in vectorfeature for every distinct image using bag of features
        number_image_folders =size([trainingSet.Count],2);
        k=1;
         for i=1:number_image_folders
             image_locations=[trainingSet(i).ImageLocation];
             for j=1:trainingSet(i).Count
                image_extracted{j} = imread(image_locations{j});
                vectorfeature{j} = encode(bag, image_extracted{j});
                X(k,:)=vectorfeature{j};
                Y{k}=[trainingSet(i).Description];
                k=k+1;
             end    
         end
         

        % KNN Classifier
        categoryClassifierKNN=fitcknn(X,Y,'NumNeighbors',1,'BreakTies','nearest');
        %checking accuracy for training set for KNN(confusionMatrixcalcluation) for different nearestNeighbors
        
        confMatrixKNN1=confusionMatrix(testSet,bag,categoryClassifierKNN,X,Y);
        confMatrixKNN1_mean{m}=confMatrixKNN1;
        %precision and recall calculations
        [p_KNN1 ,r_KNN1]=precision_recall(confMatrixKNN1);
        p_KNN1_mean=[p_KNN1_mean;p_KNN1];
        r_KNN1_mean=[r_KNN1_mean;r_KNN1];
        
        categoryClassifierKNN.NumNeighbors=3;
        confMatrixKNN3=confusionMatrix(testSet,bag,categoryClassifierKNN,X,Y);
        confMatrixKNN3_mean{m}=confMatrixKNN3;
        [p_KNN3 ,r_KNN3]=precision_recall(confMatrixKNN3);
        p_KNN3_mean=[p_KNN3_mean;p_KNN3];
        r_KNN3_mean=[r_KNN3_mean;r_KNN3];
        
        categoryClassifierKNN.NumNeighbors=5;
        confMatrixKNN5=confusionMatrix(testSet,bag,categoryClassifierKNN,X,Y);
        confMatrixKNN5_mean{m}=confMatrixKNN5;
        [p_KNN5 ,r_KNN5]=precision_recall(confMatrixKNN5);
        p_KNN5_mean=[p_KNN5_mean;p_KNN5];
        r_KNN5_mean=[r_KNN5_mean;r_KNN5];
   
        
        %MultiClass  SVM Classifier
        categoryClassifierSVM = trainImageCategoryClassifier(trainingSet, bag,'Verbose',false);
        %checking accuracy for training set for SVM(inbuilt function provided)
        confMatrixSVM = evaluate(categoryClassifierSVM, testSet,'Verbose',false);
        confMatrixSVM_mean{m}=confMatrixKNN5;
        [p_SVM ,r_SVM]=precision_recall(confMatrixSVM);
        p_SVM_mean=[p_SVM_mean;p_SVM];
        r_SVM_mean=[r_SVM_mean;r_SVM];

       % saving the set wise results 
        filename=strcat('data_generated\core_data\data_',int2str(allCodeBook(qq)),'_',method,'_',int2str(m));
        save(filename,'categoryClassifierKNN','categoryClassifierSVM','codeBookSize','confMatrixKNN1','confMatrixKNN3','confMatrixKNN5','confMatrixSVM','p_KNN1','p_KNN3','p_KNN5','p_SVM','r_KNN1','r_KNN3','r_KNN5','r_SVM','testSet','trainingSet','bag','imgSets');

    end
    
    %saving the important result
    filename=strcat('data_generated\data_results\data_results_',int2str(allCodeBook(qq)),'_',method);
    save(filename,'confMatrixKNN1_mean','confMatrixKNN3_mean','confMatrixKNN5_mean', 'confMatrixSVM_mean','p_KNN1_mean','p_KNN3_mean','p_KNN5_mean','p_SVM_mean','r_KNN1_mean','r_KNN3_mean','r_KNN5_mean','r_SVM_mean','imgSets');

    %calcul,ating performance related details
    precision_KNN1=mean(mean(p_KNN1_mean));
    precision_KNN3=mean(mean(p_KNN3_mean));
    precision_KNN5=mean(mean(p_KNN5_mean));
    precision_SVM=mean(mean(p_SVM_mean));
    
    recall_KNN1=mean(mean(r_KNN1_mean));
    recall_KNN3=mean(mean(r_KNN3_mean));
    recall_KNN5=mean(mean(r_KNN5_mean));
    recall_SVM=mean(mean(r_SVM_mean));
    
    accuracyKNN1=mean(diag((confMatrixKNN1_mean{1}+confMatrixKNN1_mean{2}+confMatrixKNN1_mean{3})/3));
    accuracyKNN3=mean(diag((confMatrixKNN3_mean{1}+confMatrixKNN3_mean{2}+confMatrixKNN3_mean{3})/3));
    accuracyKNN5=mean(diag((confMatrixKNN5_mean{1}+confMatrixKNN5_mean{2}+confMatrixKNN5_mean{3})/3));
    accuracySVM=mean(diag((confMatrixSVM_mean{1}+confMatrixSVM_mean{2}+confMatrixSVM_mean{3})/3));
    
    
    %saving the performance results only
    filename=strcat('data_generated\performace_data\data_',int2str(allCodeBook(qq)),'_',method,'_performance');
    save(filename,'precision_KNN1','precision_KNN3','precision_KNN5','precision_SVM','recall_KNN1','recall_KNN3','recall_KNN5','recall_SVM','accuracyKNN1','accuracyKNN3','accuracyKNN5','accuracySVM');
   
 
%The following format can be used for categorizing a random image
%img = imread(fullfile(rootFolder, 'airplanes', 'image_0690.jpg'));
%[labelIdx, scores] = predict(categoryClassifier..., encode(bag,img));
% Display the string label
%labelIdx                                   forKNN 
%categoryClassifier.Labels(labelIdx)        for SVM

%     end
% end

