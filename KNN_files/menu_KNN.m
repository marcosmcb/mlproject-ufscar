function menu_KNN( train_data, test_data )

    resp = input('\nDeseja rodar 10-fold cross validation? [ 1-Sim 0-Nao ]\n> ');

    num_fold = 10;
	resp_grid = 0;
    K = 11; % default value when grid-search is not selected
	
	[~, ~, ~] = mkdir('KNN_results');

	if resp
		
		[ nRows, nCols ] = size( train_data );
		elementsInFold = ceil( nRows / num_fold );
		
		for k_fold=1:num_fold
			
			beg_row = ((k_fold-1) * elementsInFold)+1;
			end_row =  k_fold * elementsInFold;

			if k_fold == num_fold
				end_row = nRows;
			end;

			if resp_grid == 0;
				resp_grid = input('Deseja rodar grid-search? [ 1-Sim 0-Nao ]\n>');
			end;
			tic
			
			if resp_grid

				% We only get even values because our number of classes is odd. So, we don't get a draw
				for K_idx = 2:2:ceil( sqrt(nCols) )
					fprintf('Running KNN...\n\n\nFOLD [%d]\nK[%d]\n\n', k_fold, K_idx);
					fprintf('Valor de beg_row[%d], end_row[%d]\n\n', beg_row, end_row);
					resp_mat = knn( train_data( beg_row:end_row, : ), K );
					knn_fold_file = strcat('./KNN_results/knn_foldAndGrid_', int2str(k_fold), '_KVal_', int2str(K), '.mat') ;
					save( knn_fold_file, 'resp_mat' );
					fprintf( 'Salvando arquivo: [%s]\n\n', knn_fold_file );
					
					toc;
				end;

			else
				
				fprintf('Running KNN...\n\n\n FOLD [%d] \n K[%d]', k_fold, K);

				resp_mat = knn( train_data( beg_row:end_row, : ), K );
				
				knn_fold_file = strcat('./KNN_results/knn_fold_', int2str(k_fold), '_KVal_', int2str(K), '.mat') ;
				save( knn_fold_file, 'resp_mat' );
				
				fprintf('Salvando arquivo: [%s]\n\n', knn_fold_file );
				
				toc
				break;
			end;

		end;

	else
		fprintf('Running KNN... (Takes about 15 min to run)\n');
		fprintf('Without n-fold or grid search (k=%g)...\n\n\n', K);
		tic
		
		resp_mat = knn( train_data, K );
		
		knn_file = strcat('./KNN_results/knn_simple_KVal_', int2str(K), '.mat') ;
		save( knn_file, 'resp_mat' );
		fprintf( 'Salvando arquivo: [%s]\n\n', knn_file );
		
		toc
	end;

end
