function [ dist_arr ] = calcDistance(  Dataset, target, idx_target )

	mat = Dataset;

	mat(idx_target,:) = [];

	[ mat, target, age_mat_col, age_target ] = deleteClassRow( mat, target, 8);

	ham_dist = pdist2( mat, target, 'hamming' );

	euc_dist = pdist2( age_target, age_mat_col, 'euclidean' );

	dist_arr = euc_dist' + ham_dist ;
    
end