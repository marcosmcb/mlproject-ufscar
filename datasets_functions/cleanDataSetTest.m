% Attr: Dataset, array de indices com celulas com algum valor nulos, array
%de indices com celulas com algum valor zero
% Ret: Dataset Limpo
function [train_data] = cleanDataSetTest( train_data, empty_arr, zeros_arr, biggestAge, smallestAge )
    
    for idx=1:10
        train_data{idx} = removeEmptyAndNoisyCellsTest( empty_arr, zeros_arr, train_data{idx}, biggestAge, smallestAge);
    end

end
