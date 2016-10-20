im = imread('72.jpg');
imbw = imread('bw72.jpg');
props = getfeatures(im,imbw);
cpre = predict(Md1, props)
