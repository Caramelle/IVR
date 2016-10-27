function [ im ] = getNormalizedImage(I )
% Perform RGB normalization
DI=double(I);
DI=DI+1e-10;
im = bsxfun(@rdivide, DI, sum(DI,3,'native'));

end

