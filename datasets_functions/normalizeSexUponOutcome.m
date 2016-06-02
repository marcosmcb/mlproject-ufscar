function [ sex_arr, sex_uniques_arr ] = normalizeSexUponOutcome( sex_arr )

	arr = cellstr( sex_arr );
	empty_cells = cellfun( @isempty, arr );
	resp = find( empty_cells == 1 );
	sex_arr( resp ) = { 'Unknown' };
	sex_uniques_arr = unique( sex_arr, 'stable' );

end