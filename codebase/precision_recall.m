function [precision, recall] = precision_recall(confusion_matrix)
    size_of_matrix = size(confusion_matrix,1);
    TPs = zeros(1,size_of_matrix);
%     TNs = zeros(size_of_matrix);
    FNs = zeros(1,size_of_matrix);
    FPs = zeros(1,size_of_matrix);
    precision = zeros(1,size_of_matrix);
    recall = zeros(1,size_of_matrix);
    
    for i=1:size_of_matrix;
        TPs(i) = confusion_matrix(i,i);
    end;
    
    for i=1:size_of_matrix;
        for j=1:size_of_matrix;
            if j ~= i;
                FPs(i) = FPs(i) + confusion_matrix(j,i);
            end;
        end;
    end;
    
    for i=1:size_of_matrix;
        for j=1:size_of_matrix;
            if j ~= i;
                FNs(i) = FNs(i) +  confusion_matrix(i,j);
            end;
        end;
    end;
    
%     Total = 0;
    
%      for i=1:size_of_matrix;
%         for j=1:size_of_matrix;
%                Total = Total + confusion_matrix(i,j);
%         end;
%     end;
%     
   % TNs = Total - FNs - FPs - TPs;
    precision = TPs./(TPs + FPs);
    recall = TPs./(TPs + FNs);
    
end