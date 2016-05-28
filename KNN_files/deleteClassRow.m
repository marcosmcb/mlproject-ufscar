function [ Dataset, target, age_dataset_col, age_target ] = deleteClassRow( Dataset, target, age_idx )

	% Delete class row from Dataset and target
	% The class's rows are the 5 last ones
	Dataset(:, end-4:end) = [];
	target( :, end-4:end) = [];

	% Get age column to compute euclidean distance
	% Also, delete the age column from the dataset to compute Hamming distance
	age_dataset_col = Dataset(:, age_idx );
	Dataset( :, age_idx) = [];

	% Get age value from target and delete from the row
	age_target = target( 1, age_idx );
	target( :, age_idx) = [];

end