vec=zeros(59,9);
for i=1:59
    im=imread([num2str(i) '.jpg']);
    imbw = imread(['bw' num2str(i) '.jpg']);
    vec(i,:)=getfeatures(im, imbw);
end

Md1 = fitcnb(vec, classes);

