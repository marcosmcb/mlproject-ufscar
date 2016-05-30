function [zeros_arr , empty_arr] = getEmptyAndZeroCells( arr )
    
    ages = cellstr( arr );
    empty_arr = ~cellfun( @isempty, ages );  
    zeros_arr = find( ismember(ages, '0 years' ) );

end