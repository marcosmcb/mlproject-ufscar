function [ K, perc ] = KNN_treinar( trainData, nColsAlvo )

	fprintf('Rodando 10-fold cross validation ...\n');

    num_fold = 10;
	
	[~, ~, ~] = mkdir('resultados_KNN');

		
	[ nRows, nCols ] = size( trainData );
	elementsInFold = ceil( nRows / num_fold );
	
	max_grid = ceil( sqrt(nCols) );

	percentages_K_values = zeros(num_fold * max_grid, 2 );
	percentage_rows = 1;

	for k_fold=1:num_fold
		tic;	
		beg_row = ((k_fold-1) * elementsInFold)+1;
		end_row =  k_fold * elementsInFold;

		if k_fold == num_fold
			end_row = nRows;
		end;

		
		for K_idx = 1:max_grid
			tic;
			fprintf('Rodando KNN-Fold-[%d] \t Com K = [%d] - Numero de Elementos no Fold = [%d]\n', k_fold, K_idx, (end_row - beg_row) );
			result = knn( trainData( beg_row:end_row, : ), K_idx, nColsAlvo, 0 );

			true_classes = trainData( beg_row:end_row, end-4:end );
			normalized_result = normalizeKNNResult( result );
			[ right_instances, percentage ] = evaluateKNN( normalized_result, true_classes );
			
			fprintf( 'Resultado da Avaliacao do KNN com K = [%d] eh: Acertos[%d] / Total[%d]\n', K_idx, right_instances, size(normalized_result,1)); 
			fprintf( 'Porcentagem de Acerto[%f]\n', percentage );

			percentages_K_values( percentage_rows, 1 ) = K_idx;
			percentages_K_values( percentage_rows, 2 ) = percentage;
			percentage_rows = percentage_rows + 1;
			toc;			
		end;
		toc;
	end;
	
	[perc, besK_idx] = max( percentages_K_values( :,2 ) );

	K = percentages_K_values( besK_idx, 1 );

	save( 'resultados_KNN/avaliacao_K_folds.mat', 'percentages_K_values', 'K', 'perc' );

end
