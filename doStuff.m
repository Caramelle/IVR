n=size(names,1);
vec=zeros(n,3);
for i=1:13
    
    im=plz([num2str(i) '.jpg']);
    vec(i,:)=getproperties(im);
end

classes=[1,2,2,3,3,1,1,2,2,3,1,3,1];
numclasses=3;
dim=2;
[m,i,a]=buildmodel(dim,vec,n,numclasses,classes);

% classifies a test feature vector v into one of N classes
% given the class means (Means) and inverse of covariance matrices
% (Invcors) and aprori probabilities (Aprioris)
v=getproperties(plz('2p.jpg'));
classify(v,numclasses,m,i,2,a)