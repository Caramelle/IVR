I = imread('17.jpg');
original = I;
%contrast enhancement
se = strel('disk',4);
I = (I + imtophat(I,se)) - imbothat(I,se);
I = rgb2hsv(I);
bg_mean = mean(I(:));
I1 = I(:, :, 2);

I4 = imgaussfilt(I1,10);
thresholded = I4 > bg_mean - 5;
I2 = thresholded .*I4;
I3 = edge(I4, 'canny', graythresh(I2));

se_disk = strel('disk', 4);
se_line1 = strel('line',3,100);
se_line2 = strel('line',3,100);
img_dilated = imdilate(I3, se_disk);
img_dilated = imdilate(img_dilated, [se_line1 se_line2]);
closed = imclose(img_dilated, se);

img_filled = imfill(closed, 'hole');
dilate_again = imdilate(img_filled, se_disk);
dilate_again = imdilate(img_filled, [se_line1 se_line2]);
closed_again = imclose(dilate_again, se);

filled_again = imfill(closed_again, 'hole');

L= bwlabel(filled_again);
regions = regionprops(L, I(:,:,1), 'BoundingBox');

for i=1:17
    img = imcrop(original, regions(i).BoundingBox);
    Name = strcat('Obj #', num2str(i));
    figure,imshow(img); title(Name);
end ,
%closed = imclose(img_dilated, se);
%skeleton = bwmorph(closed, 'branchpoints', 3);
%skeleton = bwmorph(closed, 'dilate', 3);

%filled = imfill(skeleton, 'hole');

