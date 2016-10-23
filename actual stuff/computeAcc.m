% to classify: run manualClassification(9)
% to change features, edit getfeatures.m
% to get input: run getInputVectors(nrfeatures,9)

theclasses=load('savedtags.mat');
theclasses=theclasses.tags;
input=load('savedinput.mat');
input=input.vec;

n=size(theclasses,2);
[training,testing]=dividerand(n,0.8,0.2);

trainIn=input(training,:);
trainOut=theclasses(training);

model=fitcnb(trainIn,trainOut);

testIn=input(testing,:);
testOut=theclasses(testing);
testOut=testOut(:);

predictions=predict(model,testIn);

gotRight=sum(cellfun(@strcmp,predictions,testOut));
accuracy=double(gotRight)/size(testIn,1);
disp(accuracy);