test_image = 'input/02.jpg';
predictions = makePrediction(test_image);
predictions = predictions(:);
priceMap=getPriceMap();
thesum = 0;
for i=1:size(predictions)
    p=predictions{i};
    value = priceMap(p{1});
    thesum = thesum + value;
end
thesum = thesum/100;
disp(thesum);