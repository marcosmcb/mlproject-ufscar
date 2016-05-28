function [ dist_arr ] = calcDistance( target, Dataset, idx_target )

	% We subtract one because we don't consider the target value
	nRows = size(Dataset,1) - 1;

	[ Dataset, target, age_dataset_col, age_target ] = deleteClassRow( Dataset, target, 8);

	dist_arr = zeros( nRows, 1 );

	for idx = 1 : nRows

		if idx == idx_target
			continue;
		end;

		ham_dist = pdist2( Dataset(idx,:), target(), 'hamming' );

    	euc_dist = pdist2( age_target, age_dataset_col(idx,:), 'euclidean' );

    	dist_arr(idx,1) = ham_dist + euc_dist;

	end

end