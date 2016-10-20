function [ compactness] = getCompactness(im1 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
area=bwarea(im1);
perim=bwarea(bwperim(im1,4));
compactness=perim*perim/(4*pi*area);
end

