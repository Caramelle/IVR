function [ med ] = getMedianBackground()
% Get the background image by computing the median value at every pixel

all={'02.jpg';'03.jpg';'04.jpg';'05.jpg';'06.jpg';'07.jpg';
     '08.jpg';'09.jpg';'010.jpg';'017.jpg';'018.jpg';'019.jpg';
     '020.jpg';'021.jpg'};
all=strcat('input/',all);
n=size(all,1);

list=zeros(480,640,3,n);
for i=1:n
    im=imread(all{i});
    list(:,:,:,i)=imgaussfilt(im ,0.1);
end

med=median(list,4);

end

