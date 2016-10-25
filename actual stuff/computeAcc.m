% to classify: run manualClassification(9)
% to change features, edit getfeatures.m
% to get input: run getInputVectors(nrfeatures,9)

theclasses=load('savedtags.mat');
theclasses=theclasses.tags;
input=load('savedinput2.mat');
input=input.vec;



trainIn=input(1:111,:);
trainOut=theclasses(1:111);

model2=fitcnb(trainIn,trainOut);

testIn=input(112:125,:);
testOut=theclasses(112:125);
testOut=testOut(:);

predictions=predict(model2,testIn);
disp(predictions)
disp(testOut);
gotRight=sum(cellfun(@strcmp,predictions,testOut));
accuracy=double(gotRight)/size(testIn,1);
disp(accuracy);


cvmodel = crossval(model2,'kfold',5);
cvError = kfoldLoss(cvmodel);
disp(1-cvError);
save('fittedbayes2.mat','model2');