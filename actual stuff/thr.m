function [ q ] = thr( absv,thres)
% Threshold foreground objects
[x,y]=size(absv);
q=ones(x,y);
q(absv<thres)=0;

end

