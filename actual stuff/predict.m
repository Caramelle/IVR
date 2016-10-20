im = imread('73.jpg');
imbw = imread('bw73.jpg');
props = getfeatures(im,imbw);
cpre = predict(Md1, props)