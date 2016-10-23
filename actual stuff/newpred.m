function [ fin ] = newpred(  )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

theim='03.jpg';

%normalize all images
%for i=1:n
%     im=getNormalizedImage(all{i});
%     figure;
%     imshow(im);
%     imwrite(im,['n' all{i}]);
%end



k=0;
p=9;
w=0;
medb=getMedianB();
vec=load('thevec');
vec=vec.vec;
a=load('theclasses');
a=a.a;
model=fitcnb(vec,a);

    I=imread(theim);
    fin=getFin(I,medb);
%fin=bwmorph(fin,'close',1);

figure; imshow(fin);


  [labels,nan]=bwlabel(fin);
  rp=regionprops(labels);
  smalls=find([rp.Area]<300);
  [x,y] = size(rp);

  for i=1:size(smalls,2)

     coord=round(rp(smalls(i)).BoundingBox);
     fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
  end

   bigs=find([rp.Area]>=300);
   
  
   for i=1:size(bigs,2)
      w=w+1;
     img = imcrop(I, rp(bigs(i)).BoundingBox);
      bwimg=imcrop(fin,rp(bigs(i)).BoundingBox);
     props=getProperties(img,bwimg);
    %figure,imshow(bwimg);
     thepred=predict(model,props);
    %imwrite(img,[Name '.jpg']);
    
      
         
     
   end
   
   
   end 


