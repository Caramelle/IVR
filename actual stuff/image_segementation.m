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

median=getMedianBackground(list,4);

%order: 5, 3, 2, 4

I= imread('010.jpg');
original_image = double(I);
blurred_image = imgaussfilt(original_image,0.1);
se = strel('disk',3);
contrasted_image = (blurred_image + imtophat(blurred_image,se)) - imbothat(blurred_image,se);

absv=abs(contrasted_image-median);
r=absv(:,:,1);
g=absv(:,:,2);
b=absv(:,:,3);
diff_R=thr(r,19);
diff_G=thr(g,19);   
diff_B=thr(b,25);
fin=diff_R|diff_B|diff_G;
% fin = bwmorph(fin, 'open');
% fin = bwmorph(fin, 'majority');
% fin = bwmorph(fin, 'diag');
% fin = bwmorph(fin, 'close');

%BW=(bwmorph(fin,'bridge',7));
%xxx=im1.*repmat(BW,1,1,3);
%xxx=xxx.*repmat(diff_B,1,1,3);
%xxx=xxx.*repmat(diff_G,1,1,3);



[labels,nan]=bwlabel(fin);
rp=regionprops(labels);
smalls=find([rp.Area]<300);
[x,y] = size(rp);

for i=1:size(smalls,2)
    coord=round(rp(smalls(i)).BoundingBox);
    fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
end

bigs=find([rp.Area]>=300);
names={};

for i=1:size(bigs,2)
    img = imcrop(I, rp(bigs(i)).BoundingBox);
    num = i+59;
   % Name =  strcat(['bw' num2str(num)]);
    Name = num2str(num);
    names{i}=Name;
    figure,imshow(img); title(Name);
    %imwrite(img,[Name '.jpg']);
end 
