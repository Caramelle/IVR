function [predv] = makePrediction (impath)
% Segment and classify objects in given image


% initialize model
theclasses=load('savedtags.mat');
theclasses=theclasses.tags;
themodel=load('fullcvmodel.mat');
themodel=themodel.modelcv;

% initialize variables
n=size(theclasses,2);
nrobjs=0;
thesum=0;
priceMap=getPriceMap;

I= imread(impath);

% bw final result after segmenting
medB=getMedianBackground();
fin=getForeground(I,medB);
   
[labels,nan]=bwlabel(fin);
rp=regionprops(labels);
smalls=find([rp.Area]<300);

% remove small areas
for i=1:size(smalls,2)
   coord=round(rp(smalls(i)).BoundingBox);
   fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
end


bigs=find([rp.Area]>=300);

f1=figure(1);
set(f1, 'Position', [100, 100, 1049, 895]);
figure(2);
imshow(I);


for i=1:size(bigs,2)
   nrobjs=nrobjs+1;
   bBox=rp(bigs(i)).BoundingBox;
   img = imcrop(I, bBox);     
   bwimg = imcrop(fin, bBox);
 
 
   num=num2str(nrobjs);
   % get featue vector and make prediction
   props=getfeatures(img,bwimg);
   prediction=predict(themodel,props);
   value=priceMap(prediction{1});
   thesum=thesum+value;
     % plot classified object
   figure(1);
   subplot(5,5,nrobjs); 
   imshow(img);
   title([num,prediction]);
   
   figure(2);
   rectangle('Position', [bBox(1),bBox(2),bBox(3),bBox(4)],...
  'EdgeColor','r','LineWidth',2 )
   textColor = 'black';
   textBackground = 'white';
   text(bBox(1)-5, bBox(2)-5, ...
      prediction, ...
     'Color', textColor, ...
     'BackgroundColor', textBackground, ...
     'HorizontalAlignment', 'Center');
   
    
end


thesum = thesum/100;
disp(thesum);



end
  
  



