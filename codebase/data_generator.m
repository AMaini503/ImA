%script to run over all possible methods and BOOK SIZES

%--Abhijeet Kumar---%

%add a backslash at the end of the path of root directory%
root_directory='C:\Users\Abhijeet\Documents\MATLAB\cvit_summer_project_2015\phase 1\dataset\';
all_methods={'Surf','Sift';'Brisk'};
allCodeBook=[500,1000,1500,2000,2500,3000,3500,4000,4500,5000];

allmethods_size=size(all_methods,2);
allCodeBooks_size=size(allCodeBook,2);

for ee =1:allmethods_size
    for qq=1:allCodeBooks_size
        ImageFeatureExtractionAndStorage(root_directory,allCodeBook(qq),methods{ee});
    end
end

%feature extractors with a single feature vector per image 
methods={'Gist','Hog'};
number_categories=28;
ImageFeatureExtractionAndStorage(root_directory,number_categories,methods{1});

ImageFeatureExtractionAndStorage(root_directory,number_categories,methods{2});