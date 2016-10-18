function [ img_filled ] = plz( name)
%UN
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
I = imread(name);
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

end

