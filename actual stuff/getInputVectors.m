function [ vec ] = getInputVectors (nrfeatures,totalim )

all={'02.jpg';'03.jpg';'04.jpg';'05.jpg';'06.jpg';'07.jpg';'08.jpg';'09.jpg';'010.jpg'
    ;'017.jpg';'018.jpg';'019.jpg';'020.jpg';'021.jpg'};

theclasses=load('savedtags.mat');
medB=load('savedBackground.mat');
medB=medB.med;
theclasses=theclasses.tags;
n=size(theclasses,2);
vec=zeros(n,nrfeatures);
nrobjs=0;
for nrim=1:totalim
   I= imread(['input/' all{nrim}]);
   fin=getFin(I,medB);

   [labels,nan]=bwlabel(fin);
   rp=regionprops(labels);
   smalls=find([rp.Area]<300);

   for i=1:size(smalls,2)
     coord=round(rp(smalls(i)).BoundingBox);
     fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
   end

    bigs=find([rp.Area]>=300);


  for i=1:size(bigs,2)
     nrobjs=nrobjs+1;
     img = imcrop(I, rp(bigs(i)).BoundingBox);
     bwimg = imcrop(fin, rp(bigs(i)).BoundingBox);
     num=num2str(nrobjs);
     props=getfeatures(img,bwimg);
     vec(nrobjs,:)=props;
  end 
  
end

save('savedinput.mat','vec');

end

