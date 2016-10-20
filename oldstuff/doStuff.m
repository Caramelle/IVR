n=size(names,1);
vec=zeros(n,3);
for i=1:22
    
    im=imread(['s' num2str(i) '.jpg']);
    vec(i,:)=getproperties(im);
end

classes=[1,2,3,3,3,3,3,3,3,3,2,1,2,2,2,2,2,1,1,1,1];
numclasses=3;
dim=3;
[m,i,a]=buildmodel(dim,vec,n,numclasses,classes);
% classifies a test feature vector v into one of N classes
% given the class means (Means) and inverse of covariance matrices
% (Invcors) and aprori probabilities (Aprioris)
image = imread('s10.jpg');
v=getproperties(image);
classify(v,numclasses,m,i,dim,a)