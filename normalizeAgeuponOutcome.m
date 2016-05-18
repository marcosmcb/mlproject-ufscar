function [ ages_arr ] = normalizeAgeuponOutcome( ages )
    
    ages_arr = strrep( ages, 'years', '#365' );
    ages_arr = strrep( ages_arr, 'year', '#365' );
    ages_arr = strrep( ages_arr, 'months', '#30' );
    ages_arr = strrep( ages_arr, 'month', '#30' );
    ages_arr = strrep( ages_arr, 'weeks', '#7' );
    ages_arr = strrep( ages_arr, 'week', '#7' );
    ages_arr = strrep( ages_arr, 'days', '#1' );
    ages_arr = strrep( ages_arr, 'day', '#1' );
    ages_arr = regexp( ages_arr, ' #', 'split' );
end
