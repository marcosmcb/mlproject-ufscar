function [ resp_mat ] = knn( Dataset, K, nColsClass, TestData )

	colAge = 8;
	sizeTestData = size( TestData, 1 );


	trainData  = Dataset( : , 1:end-nColsClass);
	classesCols = Dataset( : , end-nColsClass+1:end);

	[nRows, nCols] = size( trainData );
	nRowsTraining = nRows;
	target = zeros( 1,nCols );
	distances = zeros( nRows,2 );
	trainData = [trainData(  :,1:colAge-1 ), trainData( :,colAge+1:end )];
	age_mat_col = trainData( :,colAge );

	% Runs Training Dataset to choose the best value of K
	if sizeTestData == 1
		resp_mat = zeros(nRows,nColsClass);

	% Runs the Test Dataset
	else
		age_test_col = TestData( :,colAge );
		resp_mat = zeros(sizeTestData, nColsClass);
		nRows = sizeTestData;
		TestData = [TestData(  :,1:colAge-1 ), TestData( :,colAge+1:end )];
	end;


	tic;

	fprintf('Rodando KNN na base de testes \n\n');
	tic;
	for idx = 1:nRows
		% Get target sample, age column and the binary columns
		if sizeTestData == 1
			target = trainData( idx, : );
			age_target = age_mat_col( idx );
		else
			target = TestData( idx, : );
			age_target = age_test_col( idx );
		end;

		% Compute the euclidean distance for the age column and the hamming distance for the binary columns
		distances( :,1 ) = 1:nRowsTraining; % saves index of all elements
		distances( :,2 ) = pdist2( age_target, age_mat_col, 'euclidean' ) + pdist2( target, trainData, 'hamming' );		

		% Select the K-nearest samples and store the percentage of our target belong to each different class
		distances = sortrows(distances, 2);

		% We don't consider the first element because it is the target element (the nearest is himself)
		knn_arr = distances(2:K+1,:);
		classes_neighbours = classesCols(knn_arr(:,1), :);

		resp_mat(idx,:) = sum(classes_neighbours) ./ K;
		%toc
	end	
	toc;
	
end