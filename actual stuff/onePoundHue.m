function [ frac ] = onePoundHue( i,bwi,bot,top )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
i=rgb2hsv(i);
h=i(:,:,1);
obj_pixels=size(h(bwi~=0),1);
thr_pixels=size(h(h>bot & h<top),1);
frac=thr_pixels/obj_pixels;
end

