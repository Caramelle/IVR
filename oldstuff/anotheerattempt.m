all={'02.jpg';'03.jpg';'04.jpg';'05.jpg';'06.jpg';'07.jpg';'08.jpg';'09.jpg';'10.jpg';'17.jpg';'18.jpg';'19.jpg';'20.jpg';'21.jpg'};
n=size(all,1);

% for i=1:n
%     im=getNormalizedImage(all{i});
%     imshow(im);
%     imwrite(im,['n' all{i}]);
% end
    
list=zeros(480,640,3,n);
for i=1:n
    list(:,:,:,i)=imgaussfilt(imread([ 'p' all{i}]) ,0.1);
end

median=getMedianBackground(list,4);


im1=double(imread('p03.jpg'));
I= imgaussfilt(im1,0.1);
se = strel('disk',4);
im1 = (I + imtophat(I,se)) - imbothat(I,se);
%imshow(imf);

%change=open(2,coloror(thr(35,abs(im1-median))));
imhsv = rgb2hsv(im1);
imnorm = imhsv(:,:,2);
BW=(bwmorph(imnorm,'majority',7));
%BW=(~BW);
%[x,y] = size(BW);
xxx=im2.*repmat(BW,1,1,3);
xxx=xxx.*repmat(diff_B,1,1,3);
xxx=xxx.*repmat(diff_G,1,1,3);
%xx2=BW.*im1(:,:,2);dif_R
%figure;
%imshow(fin)
se_close = strel('disk', 1);
fin = imclose(fin, se_close);

[labels,nan]=bwlabel(fin);
rp=regionprops(labels);
smalls=find([rp.Area]<50);
[x,y] = size(rp);
for i=1:size(smalls,2)
    coord=round(rp(smalls(i)).BoundingBox);
    fin(coord(2):coord(2)+coord(4),coord(1):coord(1)+coord(3))=0;
end

bigs=find([rp.Area]>=50);
names={};
for i=1:size(bigs,2)
    img = imcrop(fin, rp(bigs(i)).BoundingBox);
    Name = strcat('s', num2str(i));
    names{i}=Name;
    %figure,imshow(img); title(Name);
    %imwrite(img,[Name '.jpg']);
end ,
%figure;
%imshow(fin);
    

