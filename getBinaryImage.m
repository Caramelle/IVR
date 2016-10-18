function [binary_im ] = getBinaryImage( path )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

im=myjpgload(path,0);
hist=dohist(im,0);
thresh=findthresh(hist,4,0);
binary_im=im<thresh;
end

