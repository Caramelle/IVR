function [ ] = lab2threshold( image,threshold )
%LAB2THRESHOLD Summary of this function goes here
%   Detailed explanation goes here
    im=myjpgload(image,0);
    binary_im=im>threshold; %0 for black, below thershold is object, 1(255) is white background
    imshow(binary_im);
end

