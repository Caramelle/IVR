test_image = '02.jpg';
predictions = makePrediction(test_image, 1,1,1);
predictions = predictions(:);
getPriceMap;
sum = 0;
for i=1:size(predictions)
    value = priceMap(predictions{i});
    sum = sum + value;
end

value = sum/100