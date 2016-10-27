function [ frac ] = hueThresh( i,bwi,bot,top )
% Return the ratio of pixels withing a certain hue range

i=rgb2hsv(i);
h=i(:,:,1);
obj_pixels=size(h(bwi~=0),1);
thr_pixels=size(h(h>bot & h<top),1);
frac=thr_pixels/obj_pixels;
%figure;
%xlabel('HueValue');
%ylabel('Frequency');
%histogram(h(:),50);
end

