function [ q ] = thr( absv,thres)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 %0.023
[x,y]=size(absv);
q=ones(x,y);
q(absv<thres)=0;

end

