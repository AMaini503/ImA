% confusion Matrix for KNN   generic function call is present for Multicalss SVM%
%--Abhijeet Kumar---%


function confMatrix=confusionMatrix(testSet,bag,categoryClassifier,X,Y)

% all the places are stored
for i=1:size([testSet.Count],2)
    places{i}=testSet(i).Description;
end

%initialize confusionMatrix with zeros
confMatrix=zeros(size([testSet.Count],2));


%confusionMatrix Calculation
for i=1:size([testSet.Count],2)
    for j=1:testSet(i).Count
        img=imread(testSet(i).ImageLocation{j});
        s=encode(bag,img);
       % class=predict(categoryClassifier,double(s));
       % class{1}=class{1}(1:5);
%        testSet(i).ImageLocation{j}(90:94);
        
        index=knnsearch(double(X),double(s),'K',categoryClassifier.NumNeighbors);
        %index_size=size(index,2);
        
        if ismember(testSet(i).Description,Y(index))
        %if class{1}==testSet(i).ImageLocation{j}(90:94)
             confMatrix(i,i)=confMatrix(i,i)+1/testSet(i).Count;
        else
            cat=Y(index);
              for k=1:length(places)
                  if length(cat{1})==length(places{k})
                      if cat{1}==places{k}
                          confMatrix(i,k)=confMatrix(i,k)+1/testSet(i).Count;
                      end
                  end
              end
         end
    end
end

    