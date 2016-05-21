function [zeros_arr , empty_arr] = getEmptyAndZeroCells( arr )
    
    ages = cellstr( arr );
    empty_arr = ~cellfun( @isempty, ages );
    %ages = ages( empty_cell_arr );
    
    zeros_arr = find( ismember(ages, '0 years' ) );
    %zeros_idxs = zero_years_arr;
    %ages( zero_years_arr ) = [];

end