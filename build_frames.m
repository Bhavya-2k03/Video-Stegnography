function [height,width]=build_frames(video,workingDir,framePathRGB,framePathY,framePathU,framePathV)
   count=1;
   while hasFrame(video)
     img=readFrame(video);
     height=size(img,1);
     width=size(img,2);

     Y,U,V=rgb2yuv(img);
     filename=[sprintf('%d',count) '.bmp'];
     fullname=fullfile(workingDir,framePathRGB,filename);
     imwrite(img,fullname);
     fullname=fullfile(workingDir,framePathY,filename);
     imwrite(Y,fullname);
     fullname=fullfile(workingDir,framePathU,filename);
     imwrite(U,fullname);
     fullname=fullfile(workingDir,framePathV,filename);
     imwrite(V,fullname);
     count=count+1;
   end
end