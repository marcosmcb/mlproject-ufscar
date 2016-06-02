function [ final_mat ] = normalizeKNNResult( resp_mat )

	[ nRows, nCols ] = size( resp_mat ); 
	final_mat = zeros( nRows, nCols );

	for idxRow = 1:nRows
		[ ~, idx ] = max( resp_mat( idxRow, 1:end ) );
		final_mat( idxRow, idx ) = 1;
	end

end