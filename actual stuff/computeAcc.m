% compute accuracy using random split and 5-fold cv

theclasses=load('savedtags.mat');
theclasses=theclasses.tags;
input=load('savedinput.mat');
input=input.vec;

% divide random
[train,test]=dividerand(125,0.8,0.2);
trainIn=input(train,:);
trainOut=theclasses(train);

model=fitcnb(trainIn,trainOut);

testIn=input(test,:);
testOut=theclasses(test);
testOut=testOut(:);

predictions=predict(model,testIn);
gotRight=sum(cellfun(@strcmp,predictions,testOut));
accuracy=double(gotRight)/size(testIn,1);
disp(accuracy);

% cross-validation

modelcv=fitcnb(input,theclasses,'Prior','uniform');
cvmodel = crossval(model5,'kfold',5);
cvError = kfoldLoss(cvmodel);
yp=cvmodel.kfoldPredict();
order = {'twopounds', 'poundcoin', '50p', '20p', '5p', ...
         'smallholewasher', 'bigholewasher', 'anglebracket',...
          'battery', 'nut'};

cf=confusionmat(theclasses,yp,'order',order);
cf=bsxfun(@rdivide,cf,sum(cf,2));
HeatMap(cf, 'RowLabels', order, 'ColumnLabels', order,'ColorMap',colormap('summer'));

disp(order);
disp(cf);
disp(1-cvError);
save('fullcvmodel.mat','modelcv');