function vec = getfeatures(Image, ImageBW)

     [H,W] = size(Image);
     area = bwarea(ImageBW);
     perim = bwarea(bwperim(ImageBW,4));
     
     % compactness
     compactness = perim*perim/(4*pi*area);

     % rescale properties so all have size proportional
     % to image size
%     vec = [4*sqrt(area), perim, H*compactness];

% get scale-normalized complex central moments
c11 = complexmoment(ImageBW,1,1) / (area^2);
c20 = complexmoment(ImageBW,2,0) / (area^2);
c30 = complexmoment(ImageBW,3,0) / (area^2.5);
c21 = complexmoment(ImageBW,2,1) / (area^2.5);
c12 = complexmoment(ImageBW,1,2) / (area^2.5);
%c=[c11,c20,c30,c21,c12]

  % get invariants, scaled to [-1,1] range
ci1 = real(c11);
ci2 = real(1000*c21*c12);
tmp = c20*c12*c12;
ci3 = 10000*real(tmp);
ci4 = 10000*imag(tmp);
tmp = c30*c12*c12*c12;
ci5 = 1000000*real(tmp);
ci6 = 1000000*imag(tmp);

%ci=[ci1,ci2,ci3,ci4,ci5,ci6]

% # of white pixels
whites = regionprops(ImageBW, 'FilledArea');
whitesvec = struct2cell(whites);
whitesmat = cell2mat(whitesvec);
whitesno = mean(whitesmat);

% centroids
centroids = regionprops(ImageBW, 'Centroid');
centroidsvec = struct2cell(centroids);
centroidsmat = cell2mat(centroidsvec);
centroidsmean = mean(centroidsmat(:,1));

% %majoraxis
% majax = regionprops(ImageBW, 'MajorAxisLength');
% majaxvec = struct2cell(majax);
% majaxmat = cell2mat(majaxvec);
% majaxmean = mean(majaxmat(:,1));
% 
% %minoraxis
% minax = regionprops(ImageBW, 'MinorAxisLength');
% minaxvec = struct2cell(minax);
% minaxmat = cell2mat(minaxvec);
% minaxmean = mean(minaxmat(:,1));



%     vec = [compactness,i1,i2,i3,i4,i5,i6,i7];
     vec = [compactness,ci1, ci2, whitesno, centroidsmean];         
end
     