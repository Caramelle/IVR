all={'02.jpg';'03.jpg';'04.jpg';'05.jpg';'06.jpg';'07.jpg';'08.jpg';'09.jpg';'010.jpg';'017.jpg';'018.jpg';'019.jpg';'020.jpg';'021.jpg'};
n=size(all,1);

%normalize all images
%for i=1:n
%     im=getNormalizedImage(all{i});
%     figure;
%     imshow(im);
%     imwrite(im,['n' all{i}]);
%end


list=zeros(480,640,3,n);
for i=1:n
    list(:,:,:,i)=imgaussfilt(imread([ all{i}]) ,0.1);
end

med=getMedianB();
%order: 5, 3, 2, 4
vec2=zeros(121,5);
k=0;
p=9;
w=0;
for j=1:p
    I=imread(all{j});
    fin=getFin(I,med);


  [labels,nan]=bwlabel(fin);
  rp=regionprops(labels);
  smalls=find([rp.Area]<50);
  [x,y] = size(rp);

  for i=1:size(smalls,2)

     coord=round(rp(smalls(i)).BoundingBox);
     fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
  end

   bigs=find([rp.Area]>=50);
   
  
   for i=1:size(bigs,2)
      w=w+1;
     img = imcrop(I, rp(bigs(i)).BoundingBox);
     bwimg=imcrop(fin,rp(bigs(i)).BoundingBox);
     
    
    % figure,imshow(img); title(Name);
    %imwrite(img,[Name '.jpg']);
    if ~strcmp(myc.classes{w},'nothing')
        k=k+1;
         Name =  num2str(k);
         vec2(k,:)=getProperties(img,bwimg);
     
    end
   
   
   end 
end