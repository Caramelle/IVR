function [ fin ] = getFin(I,med)
%GETFIN Summary of this function goes here
%   Detailed explanation goes here
original_image = double(I);
blurred_image = imgaussfilt(original_image,0.1);
se = strel('disk',3);
contrasted_image = (blurred_image + imtophat(blurred_image,se)) - imbothat(blurred_image,se);

absv=abs(contrasted_image-med);
r=absv(:,:,1);
g=absv(:,:,2);
b=absv(:,:,3);
diff_R=thr(r,19);
diff_G=thr(g,19);   
diff_B=thr(b,25);
fin=diff_R|diff_B|diff_G;
fin=bwareaopen(fin,60);

end

