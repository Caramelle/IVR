
i=imread('output/35.jpg');
bi=imread('output/bw35.jpg');
bi=bwmorph(bi,'close',1);
minax = regionprops(bi,rgb2gray(i), 'MeanIntensity')