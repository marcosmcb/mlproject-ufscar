function [ mat, target, age_mat_col, age_target ] = deleteClassRow( mat, target, age_idx )

	% Delete class row from mat and target
	% The class's rows are the 5 last ones
	mat(:, end-4:end) = [];
	target( :, end-4:end) = [];

	% Get age column to compute euclidean distance
	% Also, delete the age column from the mat to compute Hamming distance
	age_mat_col = mat(:, age_idx );
	mat( :, age_idx) = [];

	% Get age value from target and delete from the row
	age_target = target( 1, age_idx );
	target( :, age_idx) = [];

end