%Prog to make a csv file

imagefiles = dir('*.jpg');
nfiles = length(imagefiles);

heading = {'Filename' 'Latitude Reference' 'Lat Cord1' 'Lat Cord2' 'Lat Cord3' 'Longitude Reference' 'Long Ref1' 'Long Ref2' 'Long Ref3' 'Altitude' 'Tags1' 'Tags2' 'Tags3' 'Tags4' 'Tags5'};
fid = fopen('data.csv', 'a');
fprintf(fid, '%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',heading{1,:});
fclose(fid);

for i=1:nfiles
    filenames{i} = imagefiles(i).name;
    A = imfinfo(filenames{i});
        
    %Latitude Direction mentioned in ASCII Value
    try
        latref(i) =  A.GPSInfo.GPSLatitudeRef;            
        latcord{i} = A.GPSInfo.GPSLatitude;
    catch
        latref(i) =  -999;
        latcord{i} = [-999; -999; -999];
    end
    
    %Longitude Direction mentioned in ASCII Value
    try
        lonref(i) = A.GPSInfo.GPSLongitudeRef;
        loncord{i} = A.GPSInfo.GPSLongitude;
    catch
        lonref(i) = -999;
        loncord{i} = [-999; -999; -999];
    end
    
    try
       altitude(i) = A.GPSInfo.GPSAltitude;
    catch
       altitude(i) = 0;        
    end
    
    a = {filenames{i} latref(i) latcord{i}(1) latcord{i}(2) latcord{i}(3) lonref(i) loncord{i}(1) loncord{i}(2) loncord{i}(3) altitude(i)};
    
    fid = fopen('data.csv','a');
    fprintf(fid,'%s, %s, %f, %f, %f, %s, %f, %f, %f, %f\n',a{1,:});
    fclose(fid);
    
    
    
end

