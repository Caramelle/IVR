function vec = getfeatures(Image, ImageBW)
% Returns a feature vector for given object

area = bwarea(ImageBW);
perim = bwarea(bwperim(ImageBW,4));
     
% get compactness
compactness = perim*perim/(4*pi*area);


% get scale-normalized complex central moments
c11 = complexmoment(ImageBW,1,1) / (area^2);
c21 = complexmoment(ImageBW,2,1) / (area^2.5);
c12 = complexmoment(ImageBW,1,2) / (area^2.5);

% get invariants, scaled to [-1,1] range
ci1 = real(c11);
ci2 = real(1000*c21*c12);

% get area of convex hull
ch=bwconvhull(ImageBW);
convhull_area=bwarea(ch);

%hue range thresholding
hue_thresh=hueThresh(Image,ImageBW,0.36,0.48);

% return feature vector
vec = [compactness, ci1, ci2, convhull_area,hue_thresh];  
     
end