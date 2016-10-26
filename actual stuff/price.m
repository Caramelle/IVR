test_image = '010.jpg';
makePrediction(test_image, 1,1,1);
getPriceMap;
sum = 0;
for i=1:size(predictions(:))
    value = priceMap(predictions{i});
    sum = sum + value;
end

value = sum/100