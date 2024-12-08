workingDir="frames";
mkdir(workingDir,"embeddedFramesRGB");
frameLocations={'framesY','framesU','framesV'};

for i=frameLocations
    unscramble(key,height,width,frameCount,workingDir,i{1});  % simply i wont work & indexing in matlab starts from 1 hence writing i{0} is wrong
end

for i=1:frameCount
    filename=[sprintf('%d',i) '.bmp'];
    fullname=fullfile(workingDir,'framesY',filename);
    Y=imread(fullname);

    filename=[sprintf('%d',i) '.bmp'];
    fullname=fullfile(workingDir,'framesU',filename);
    U=imread(fullname);

    filename=[sprintf('%d',i) '.bmp'];
    fullname=fullfile(workingDir,'framesV',filename);
    V=imread(fullname);
    
    RGB=yuv2rgb(Y,U,V);
    
    % imshow(RGB)

    filename=[sprintf('%d',i) '.bmp'];
    fullname=fullfile(workingDir,'embeddedFramesRGB',filename);
    imwrite(RGB,fullname); 
end
