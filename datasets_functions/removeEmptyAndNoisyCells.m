% Attr:
function [ data_arr ] = removeEmptyAndNoisyCells( empty_arr, zeros_arr, data_arr )

    data_arr = data_arr( empty_arr );
    data_arr( zeros_arr ) = [];
    
end