function string = dispImg(str1, str2)
    string = strcat(str1, str2);
    fileID = fopen('tmp.txt', 'w');
    fprintf(fileID, '%s:%f\n', string, 0.123);
    fprintf(fileID, '%s:%f\n', string, 0.15);
    fclose(fileID);
end
