function [ resp_mat ] = knn( Dataset, K)

	nRows = size( Dataset, 1);
	resp_mat = zeros( nRows, 5 );

	fprintf('Runnning KNN');

	for idx = 1:nRows

		fprintf('Running KNN for the [%d] sample\n\n', idx);

		target = Dataset( idx, : );
		dist_arr = calcDistance( Dataset, target,  idx );
		class_vals = getKNN( dist_arr, K, Dataset, idx );
		resp_mat(idx,:) = class_vals;

	end	

	save('knn_output.mat', resp_mat);

end