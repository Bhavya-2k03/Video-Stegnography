workingDir='frames';
originalVideo=VideoReader("C:\Users\DELL\Desktop\Coding\MATLAB\Final project\sample.mp4");

embededVideo=VideoWriter('embededVideo.avi','Uncompressed AVI');
embededVideo.LosslessCompression= true;
embededVideo.FrameRate=originalVideo.FrameRate;

open(embededVideo);
for i=1:frameCount
    filename=[sprintf('%d',i) '.bmp'];
    fullname=fullfile(workingDir,'embeddedFramesRGB',filename);
    img=imread(fullname);
    writeVideo(embededVideo,img);
end
close(embededVideo);

% work starting from receiver end ---> %

%mkdir(workingDir,"receiverEmbededFramesRGB");

% receivedVideo=VideoReader('embededVideo.avi');
% i=1;
% 
% while hasFrame(receivedVideo)
%     img=readFrame(receivedVideo);
%     filename=[sprintf('%d',i) '.bmp'];
%     fullname=fullfile(workingDir,"receiverEmbededFramesRGB",filename);
%     imwrite(img,fullname);
%     i=i+1;
% end

