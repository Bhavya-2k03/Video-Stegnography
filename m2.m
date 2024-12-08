message=readFile('C:\Users\DELL\Desktop\Coding\MATLAB\Final project\message.png');
messageTransposed=message';
oneD=messageTransposed(:);

cnt=1;

shift=5;
len=length(oneD);

temp=oneD(1:shift,1);

for i=1+shift:len
    oneD(i-shift,1)=oneD(i,1);
end

for i=len-key+1:len
    oneD(i,1)=temp(i-len+key,1);
end

G=[1 1 0 1 0 0 0; 0 1 1 0 1 0 0; 1 1 1 0 0 1 0; 1 0 1 0 0 0 1]; %Generator matrix
xorKey=8;
embedRow=3; %row in which bits will be embeded
imageCount=1;
coloum=1;  %coloumn in which bits will be embeded
workingDir='frames';

fullnameV='';
fullnameU='';
fullnameY='';

frameV=zeros(height,width);
frameU=zeros(height,width);
frameY=zeros(height,width);

for i=1:4:len %Itereating in blocks of 4, 4 because A (7,4) Hamming code encodes a 4-bit message into a 7-bit codeword.
    if i+3 > len
        break;
    end
    block=oneD(i:i+3,1);
    codeword=block'*G; %transpose is taken to convert 'block' into a row vector(from coloum vector) for matrix multiplication .
    
    for j=1:7 % 7 is the length of the codeword.
        block(1,j)=mod(block(1,j),2); %mod 2 is done to convert each bit of codeword to binary.
        block(1,j)=xor(block(1,j),xorKey);
    end

    if coloum==181
        coloum=1;
        imageCount=imageCount+1;
    end

    if coloum==1
         filename=[sprintf("%d",imageCount) '.bmp'];
         fullnameV=fullfile(workingDir,'framesV', filename);
         frameV=imread(fullnameV);

         filename=[sprintf("%d",imageCount) '.bmp'];
         fullNameY=fullfile(workingDir,'framesY',filename);
         frameY=imread(fullNameY);

         fileName=[sprintf("%d",imageCount) ' .bmp'];
         fullNameU=fullfile(workingDir,'framesU',filename);
         frameU=imread(fullNameU);   
    end
    
    for j=1:3
        frameY(embedRow,(coloum-1)*3+j)=temp(1,j);
    end

    frameU(embedRow,(coloum-1)*2+1)=temp(1,4);
    frameU(embedRow,(coloum-1)*2+2)=temp(1,5);

    frameV(embedRow,(coloum-1)*2+1)=temp(1,6);
    frameV(embedRow,(coloum-1)*2+2)=temp(1,7);

    imwrite(frameV,fullnameV);
    imwrite(frameU,fullnameU);
    imwrite(frameY,fullnameY);

end