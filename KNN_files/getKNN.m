function [ class_vals ] = getKNN(  dist_arr, K, Dataset, idx_target )

	Dataset( idx_target, : ) = [];
	mat_dataset_distances = [Dataset dist_arr];
	[ ~ , lastCol] = size(mat_dataset_distances);
	mat = sortrows(mat_dataset_distances, lastCol);
	
	% Get only the class's rows for the K nearest neighbors
	mat = mat( 1:K, end-5:end-1 );

	class_vals = getClasses( mat );

end
