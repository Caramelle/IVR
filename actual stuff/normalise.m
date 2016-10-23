I = imread('02.jpg');

Double_I = im2double(I);

R = Double_I(:, :, 1);
G = Double_I(:, :, 2);
B = Double_I(:, :, 3);

S = R+G+B;

NormR = R./S;
NormG = G./S;
NormB = B./S;

NormI = bsxfun(@rdivide, Double_I, S);

se = strel('disk',3);
contrasted_image = (NormI + imtophat(NormI,se)) - imbothat(NormI,se);
