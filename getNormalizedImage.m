function [ im ] = getNormalizedImage(path )
%GETNORMALIZEDIMAGE Summary of this function goes here
%   Detailed explanation goes here
I=imread(path);
DI=double(I);
DI=DI+1e-10;
im_normalized = bsxfun(@rdivide, DI, sum(DI,3,'native'));
im=im2uint8(im_normalized);
end

