d=1;
for i=60:89
    im=imread([num2str(i) '.jpg']);
    imbw = imread(['bw' num2str(i) '.jpg']);
    props = getfeatures(im, imbw);
    pred{d} = predict(Md1, props);
    d = d+1;
end

% im = imread('84.jpg');
% imbw = imread('bw84.jpg');
% props = getfeatures(im,imbw);
% cpre = predict(Md1, props)

%4