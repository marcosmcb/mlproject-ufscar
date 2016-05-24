function [names_arr] = normalizeNames( names_cells )
    
    names_arr = ~cellfun( 'isempty', names_cells );
    
end