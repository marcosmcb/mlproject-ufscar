function [ age_cells ] = normalizeAgeuponOutcome( ages )
    
    % Removing empty cells
    age_cells = cellstr( ages );
    age_cells = age_cells( ~cellfun(@isempty, age_cells) );

    % Removing zero years - 0 years
    zero_year_arr = find(ismember(age_cells, '0 years' ));
    age_cells( zero_year_arr ) = [];
    
    % Replacing the period set (day/days, week/weeks, month/months, year/years ) 
    % by its respective value in the value set(1 , 7, 30, 365)
    % 
    % We will also add a token to tokenize the string afterwards.
    age_cells = strrep( age_cells, 'years', '365' );
    age_cells = strrep( age_cells, 'year', '365' );
    age_cells = strrep( age_cells, 'months', '30' );
    age_cells = strrep( age_cells, 'month', '30' );
    age_cells = strrep( age_cells, 'weeks', '7' );
    age_cells = strrep( age_cells, 'week', '7' );
    age_cells = strrep( age_cells, 'days', '1' );
    age_cells = strrep( age_cells, 'day', '1' );
    
    [lengthArr, ~] = size(age_cells);
    age_cells = tokenizeAndMultiply( age_cells, lengthArr );

end