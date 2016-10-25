function [] = makePrediction (impath, showBack, showSubstr, showCropped )


medB=getMedianB();

theclasses=load('savedtags.mat');
theclasses=theclasses.tags;
themodel=load('fittedbayes2.mat');
themodel=themodel.model2;
n=size(theclasses,2);
nrobjs=0;

   I= imread(impath);
   if showBack
       figure;
       imshow(uint8(medB))
   end
   fin=getFin(I,medB);
   
   if showSubstr
       figure;
       imshow(fin)
   end

   [labels,nan]=bwlabel(fin);
   rp=regionprops(labels);
   smalls=find([rp.Area]<300);

   for i=1:size(smalls,2)
     coord=round(rp(smalls(i)).BoundingBox);
     fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
   end

    bigs=find([rp.Area]>=300);

  figure; 

  for i=1:size(bigs,2)
     nrobjs=nrobjs+1;
     img = imcrop(I, rp(bigs(i)).BoundingBox);
     
     bwimg = imcrop(fin, rp(bigs(i)).BoundingBox);
     bwimg=bwmorph(bwimg,'close',1);
     num=num2str(nrobjs);
     props=getfeatures(img,bwimg);
     prediction=predict(themodel,props);
   
     disp(props);
     subplot(5,5,nrobjs); 
      imshow(img);
     title([num,prediction]);
    
    
     
  end 
  
  


end
