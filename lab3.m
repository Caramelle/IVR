fs={'f6.jpg';'f7.jpg';'f8.jpg';'f9.jpg';'a1.jpg';'a2.jpg';'a3.jpg';'a4.jpg'};
n=size(fs,1);
vec=zeros(n,2);
for i=1:size(fs,1)
    
    im=getObjects(fs{i},0);
    vec(i,:)=getproperties(im);
end

classes=[1,1,1,1,2,2,2,2];
numclasses=2;
dim=2;
[m,i,a]=buildmodel(dim,vec,n,numclasses,classes)
