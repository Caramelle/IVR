function [ med ] = getMedianB()
%GETMEDIANB Summary of this function goes here
%   Detailed explanation goes here
all={'02.jpg';'03.jpg';'04.jpg';'05.jpg';'06.jpg';'07.jpg';'08.jpg';'09.jpg';'010.jpg';'017.jpg';'018.jpg';'019.jpg';'020.jpg';'021.jpg'};
n=size(all,1);

%normalize all images
%for i=1:n
%     im=getNormalizedImage(all{i});
%     figure;
%     imshow(im);
%     imwrite(im,['n' all{i}]);
%end


list=zeros(480,640,3,n);
for i=1:n
    im=imread(all{i});
    list(:,:,:,i)=imgaussfilt(im ,0.1);
end

med=median(list,4);

end

