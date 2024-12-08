workingDir='frames';
if(exist(workingDir,'dir')) 
    rmdir(workingDir,'s');
end
mkdir(workingDir);
mkdir(workingDir,'framesRGB');
mkdir(workingDir,'framesY');
mkdir(workingDir,'framesU');
mkdir(workingDir,'framesV');
video=VideoReader('C:\Users\DELL\Desktop\Coding\MATLAB\Final project\sample.mp4');

height,width=build_frames(video,workingDir,'framesRGB','framesY','framesU','framesV');

frameCount=floor(video.Duration*video.FrameRate)-1;
key=2; 

frameLocations={'framesY','framesU','framesV'};

for i=frameLocations
    scramble(key,height,width,frameCount,workingDir,i{1});  % simply i wont work & indexing in matlab starts from 1 hence writing i{0} is wrong
end



