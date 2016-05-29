function [ resp_mat ] = knn( Dataset, K)

	nColsClass = 5;
	colAge = 8;
	K = 10;

	trainData  = Dataset( : , 1:end-nColsClass);
	classesCols = Dataset( : , end-nColsClass+1:end);

	[nRows, nCols] = size( trainData );
	target = zeros( 1,nCols );
	distances = zeros( nRows,2 );

	age_mat_col = trainData( :,colAge );
	trainData = [trainData(  :,1:colAge-1 ), trainData( :,colAge+1:end )];

	resp_mat = zeros(nRows,nColsClass);
	tic;
	for idx = 1:nRows
		% Get target sample, age column and the binary columns
		target = trainData( idx, : );
		age_target = age_mat_col( idx );

		% Compute the euclidean distance for the age column and the hamming distance for the binary columns
		distances( :,1 ) = 1:nRows;
		distances( :,2 ) = pdist2( age_target, age_mat_col, 'euclidean' ) + pdist2( target, trainData, 'hamming' );		

		% Select the K-nearest samples and store the percentage of our target belong to each different class
		distances = sortrows(distances, 2);

		% We don't consider the first element because it is the target element
		knn_arr = distances(2:K+1,:);
		classes_neighbours = classesCols(knn_arr(:,1), :);

		resp_mat(idx,:) = sum(classes_neighbours) ./ K;
		toc
	end	

end