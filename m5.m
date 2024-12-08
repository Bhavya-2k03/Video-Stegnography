workingDir='frames';
receivedVideo=VideoReader('embededVideo.avi');
mkdir(workingDir,'receiverEmbededFramesRGB');
mkdir(workingDir,'receivedFramesY');
mkdir(workingDir,'receivedFramesU');
mkdir(workingDir,'receivedFramesV');
height, width=build_frames(receivedVideo,workingDir,'receiverEmbededFramesRGB','receivedFramesY','receivedFramesU','receivedFramesV');

receiverFrameLocations={'receivedFramesY','receivedFramesU','receivedFramesV'};

for i=receiverFrameLocations
    scramble(key,height,width,frameCount,workingDir,i{1});
end


%do rememeber to change names everywhere to receivedFramesV.

read_message=zeros(len,1);

r=zeros(1,7);
ht=[1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 1 1; 1 1 1; 1 0 1];
count=1;
position=1;

image_count=1;

xorKey=8;

count_diff = 1;

frameY=zeros(height,width);
frameV=zeros(height,width);
frameU=zeros(height,width);


for i=1:len
    if count>=len+1
        break
    end
    
    if position==181
        position=1;
        image_count=image_count+1;
    end
    
    if position==1
        filename=[sprintf('%d',image_count) '.bmp'];
        fullnameY=fullfile(workingDir,'receivedFramesY',filename);
        frameY=imread(fullnameY);
        filename=[sprintf('%d',image_count) '.bmp'];
        fullnameV=fullfile(workingDir,'receivedFramesV',filename);
        frameV=imread(fullnameV);
        filename=[sprintf('%d',image_count) '.bmp'];
        fullnameU=fullfile(workingDir,'receivedFramesU',filename);
        frameU=imread(fullnameU);
    end

    r(1,1)=xor(xorKey,frameY(3,(position-1)*3+1));
    r(1,2)=xor(xorKey,frameY(3,(position-1)*3+2));
    r(1,3)=xor(xorKey,frameY(3,(position-1)*3+3));
    r(1,4)=xor(xorKey,frameU(3,(position-1)*2+1));
    r(1,5)=xor(xorKey,frameU(3,(position-1)*2+2));
    r(1,6)=xor(xorKey,frameV(3,(position-1)*2+1));
    r(1,7)=xor(xorKey,frameV(3,(position-1)*2+2));
    

    z=r*ht;

    z(1,1)=mod(z(1,1),2);
    z(1,2)=mod(z(1,2),2);
    z(1,3)=mod(z(1,3),2);
    
    if (z(1,1)==0) && (z(1,2)==0) && (z(1,3)==0)
        count_diff=count_diff+1;
        read_message(count) =r(1,4);
        read_message(count+1)=r(1,5);
        read_message(count+2)=r(1,6);
        read_message(count+3)=r(1,7);
    
    elseif (z(1,1)==1) && (z(1,2)==1) && (z(1,3)==0)
        read_message(count)=~r(1,4);
        read_message(count+1)=r(1,5);
        read_message(count+2)=r(1,6);
        read_message(count+3)=r(1,7);
    
    elseif (z(1,1)==0) && (z(1,2)==1) && (z(1,3)==1)
        read_message(count)=r(1,4);
        read_message(count+1)=~r(1,5);
        read_message(count+2)=r(1,6);
        read_message(count+3)=r(1,7);

    elseif (z(1,1)==1) && (z(1,2)==1) && (z(1,3)==1)
        read_message(count)  =r(1,4);
        read_message(count+1)=r(1,5);
        read_message(count+2)=~r(1,6);
        read_message(count+3)=r(1,7);
    

    elseif (z(1,1)==1) && (z(1,2)==0) && (z(1,3)==1)
        read_message(count)=r(1,4);
        read_message(count+1)=r(1,5);
        read_message(count+2)=r(1,6);
        read_message(count+3)=~r(1,7);
        
    else 
        read_message(count)=r(1,4);
        read_message(count+1)=r(1,5);
        read_message(count+2)=r(1,6);
        read_message(count+3)=r(1,7);
        
    end   
    count=count+4;
    position=position+1;
    
end


temp=read_message(len-4:len,1);
for i= len-5:-1:1
    read_message(i+5,1)=read_message(i,1);
end
read_message(1,1)=temp(1,1);
read_message(2,1)=temp(2,1);
read_message(3,1)=temp(3,1);
read_message(4,1)=temp(4,1);
read_message(5,1)=temp(5,1);


xe=zeros(140,200);
count=1;

for i=1:140
     for j=1:200
          xe(i,j)=read_message(count,1);
          count=count+1;
     end
end
figure,imshow(xe)
imwrite(xe,'r_message.png');