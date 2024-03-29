% vec=zeros(68,9);
% for i=1:68
%     im=imread([num2str(i) '.jpg']);
%     imbw = imread(['bw' num2str(i) '.jpg']);
%     vec(i,:)=getfeatures(im, imbw);
% end
% 
% %Md1 = fitcnb(vec, classes);
% bag = bagOfFeatures(vec);
% %classifier = trainImageCategoryClassfier(c
% %knn = fitcknn(vec, classes);
% 
% %[idx, C] = kmeans(vec,10);

%imgFolder = fullfile('20p', '5p', '50p', 'anglebracket', 'battery','bigholewasher', 'nut', 'poundcoin', 'smallholewasher', 'twopound');
%imgFolder = {fullfile('50p'), fullfile('20p'), fullfile('5p'), fullfile('anglebracket'), fullfile('battery'), fullfile('bigholewasher'), fullfile('nut'), fullfile('poundcoin'), fullfile('smallholewasher'), fullfile('twopound')};
%imgFolder =fullfile('20p');
%imgSets = imageSet(imgFolder, 'recursive');

% setDir = fullfile('imagesets');
classes = load('myclasses.mat');

images = {};
 for i=1:133
    im = imread([num2str(i) '.jpg']);
    images{i,1} = im;
    images{i,2} = classes.classes{i};
 end


 [training, ValInd, test] = dividerand(133, 0.8, 0, 0.2);
 
 trainingSet ={};
 for i=1:size(training)
     trainingSet{i,1} = images{training(i),1};
     trainingSet{i,2} = images{training(i),2};
 end
 
testSet ={};
 for i=1:size(test)
     testSet{i,1} = images{test(i),1};
     testSet{i,2} = images{test(i),2};
 end
 
 
% 
% bag = bagOfFeatures(trainingSet);
% 
% categoryClassifier = trainImageCategoryClassifier(trainingSet, bag);
% 
% confMatrix = evaluate(categoryClassigier, testSet)