function [ priceMap ] = getPriceMap( )
% Return a map with coins and their values

KeySet = {'twopounds', 'poundcoin', '50p', '20p', '5p', ...
         'smallholewasher', 'bigholewasher', 'anglebracket',...
          'battery', 'nut'};
ValueSet = [200, 100, 50, 20, 5, 75, 25, 2, 0, 0];

priceMap = containers.Map(KeySet, ValueSet);


end

