function scramble (key, height, width, noOfFrames, workingDir, frameLocation)
    noOfBlocks=floor(height/key);
    if mod(noOfBlocks,2)==1
        noOfBlocks=noOfBlocks-1;
    end

    for i=1:noOfFrames
        filename=[sprintf('%d',i) '.bmp'];
        fullname=fullfile(workingDir,frameLocation,filename);
        frame=imread(fullname);
        
        for j=1:noOfBlocks/2
            if mod(j,2)==1 %We will not swap odd Blocks
              continue;
            end
            symmetricBlock=noOfBlocks-j;
            blockStartIndex=(symmetricBlock*key)+1;

            temp=frame((j-1)*key+1:j*key,:);
            frame((j-1)*key+1:j*key,:)=frame(blockStartIndex:blockStartIndex+(key-1),:);
            frame(blockStartIndex:blockStartIndex+(key-1),:)=temp;
        end

        imwrite(frame,fullname);
    end

    noOfBlocks=width/key;
    if mod(noOfBlocks,2)==1
        noOfBlocks=noOfBlocks-1;
    end
    
    for i=1:noOfFrames
        filename=[sprintf('%d',i) '.bmp'];
        fullname=fullfile(workingDir,frameLocation,filename);
        frame=imread(fullname);

        for j=1:noOfBlocks/2
            if mod(j,2)==1
                continue;
            end
            symmetricBlock=noOfBlocks-j;
            blockStartIndex=(symmetricBlock*key)+1;
    
            temp=frame(:,(j-1)*key+1:j*key);
            frame(:,(j-1)*key+1:j*key)=frame(:,blockStartIndex:blockStartIndex+(key-1));
            frame(:,blockStartIndex:blockStartIndex+(key-1))=temp;
        end

        imwrite(frame,fullname);

    end
