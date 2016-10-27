function [ tags, inputs ] = manualClassification()

% Segemnt objects and return both feature vectors 
% and their manually assigned classes

all={'02.jpg';'03.jpg';'04.jpg';'05.jpg';'06.jpg';'07.jpg';
    '08.jpg';'09.jpg';'010.jpg';'017.jpg';'018.jpg';'019.jpg';
    '020.jpg';'021.jpg'};


poss={'poundcoin';'twopounds';'bigholewasher';'smallholewasher';
     '50p';'5p';'20p';'nut';'battery';'anglebracket'};


medB=load('savedBackground.mat');
medB=medB.med;
figure;
imshow(uint8(medB));
title('Median Background');
input('Next stage?');
n=input('How many images to classify?\n');
nrobjs=0;
tags={};
inputs=[];
for nrim=1:n
   I= imread(['input/' all{nrim}]);
   fin=getFin(I,medB);

   [labels,nan]=bwlabel(fin);
   rp=regionprops(labels);
   
   % remove small objects
   smalls=find([rp.Area]<300);

   for i=1:size(smalls,2)
     coord=round(rp(smalls(i)).BoundingBox);
     fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
   end

   % select objects by area
    bigs=find([rp.Area]>=300);
    figure;
    imshow(fin);
    title('Segmentation stage');
    input('Next stage?');
    close all;

  for i=1:size(bigs,2)
     nrobjs=nrobjs+1;
     img = imcrop(I, rp(bigs(i)).BoundingBox);
     bwimg = imcrop(fin, rp(bigs(i)).BoundingBox);
     num=num2str(nrobjs);
     figure,imshow(img); title(num);
     % save objects
     imwrite(img,['output2/' num '.jpg']);
     imwrite(bwimg,['output2/bw' num '.jpg']);
     notok=true;
     while notok
     try
         theclass=input(['Class for object ', num, ' in image ',...
             num2str(nrim), '\n']);
         tags{nrobjs}=theclass;
         props=getfeatures(img,bwimg);
         inputs(nrobjs,:)=props;
         notok=false;
         if size(find(strcmp(poss,theclass)),1)==0
             notok=true;
             disp('This is not a permitted class, try again.');
         end  
     catch
         disp('Invalid input, try again.')
     end
     end 
     close all;
  end 
  
end

% save all tags for the classified objects
save('savedtags7.mat',tags);
save('savedinputs7.mat',tags);

end

