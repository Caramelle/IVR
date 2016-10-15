function [ BW ] = getObjects(im,show )
%GETOBJECTS Summary of this function goes here
%   Detailed explanation goes here
I = imread(im);
level = graythresh(I);
BW = ~im2bw(I,level);
if show > 0
     figure(show)
     clf
     imshow(BW)
end

end

