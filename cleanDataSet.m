function [train_data] = cleanDataSet( train_data, empty_arr, zeros_arr )
    
    for idx=1:10
        train_data{idx} = removeEmptyAndNoisyCells( empty_arr, zeros_arr, train_data{idx} );
    end

end