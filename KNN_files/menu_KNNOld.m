function menu_KNNOld( train_data, test_data )

    resp = input('\nDeseja rodar 10-fold cross validation? [ 1-Sim 0-Nao ]\n> ');

    num_fold = 10;
    K = 10;
    resp_grid = 0;
    if resp
		
		[ nRows,nCols ] = size( train_data );
		fold = ceil( nRows / num_fold );
		for k_fold=1:num_fold
			
			beg_row = ((k_fold-1) * fold)+1;
			end_row =  k_fold * fold;

			if  k_fold == num_fold
				end_row = nRows;
			end;

			if resp_grid == 0;
				resp_grid = input('Deseja rodar grid-search? [ 1-Sim 0-Nao ]\n>');
			end;

			if resp_grid

				% We only get even values because our number of classes is odd. So, we don't get a draw
				for K_idx = 2:2:ceil( sqrt(nCols) )
					fprintf('Running KNN...\n\n\nFOLD [%d]\nK[%d]\n\n', k_fold, K_idx);
					fprintf('Valor de beg_row[%d], end_row[%d]\n\n', beg_row, end_row);
					resp_mat = knn( train_data( beg_row:end_row, : ), K_idx );
					knn_fold_file = strcat('./KNN_results/knn_fold_', int2str(k_fold), '_KVal_', int2str(K_idx), '.mat') ;
					save( knn_fold_file, 'resp_mat' );

				end;

			else
				
				fprintf('Running KNN...\n\n\n FOLD [%d] \n K[%d]', k_fold, K);

				resp_mat = knn( train_data( beg_row:end_row, : ), K );
				knn_fold_file = strcat('./KNN_results/knn_fold_', int2str(k_fold), '_KVal_', int2str(K), '.mat') ;
				save( knn_fold_file, 'resp_mat' );
				break;
			end;

		end;

	else
		fprintf('Running KNN... (Takes about 15 min to run)\n\n\n');
		resp_mat = knn( train_data, K );
		knn_file = strcat('./KNN_results/knn_', 'KVal_', int2str(K), '.mat') ;
		save( knn_file, 'resp_mat' );
		fprintf( 'Salvando arquivo: [%s]\n\n', knn_file );
	end;

end