function menu_KNN( train_data, test_data )

    resp = input('\nDeseja rodar 10-fold cross validation? [ 1-Sim 0-Nao ]\n> ');

    num_fold = 10;
    K = 10;

    if resp
		
		[ nRows,nCols ] = size( train_data );
		fold = ceil( nRows / num_fold );
		for k_fold=1:num_fold
			
			beg_row = ((k_fold-1) * fold)+1;
			end_row =  k_fold * fold;

			if (k_fold == num_fold) and ( end_row < nRows )
				end_row = nRows
			end;

			resp_grid = input('Deseja rodar grid-search? [ 1-Sim 0-Nao ]\n>');

			if resp_grid

				for K = 1:ceil( sqrt(nCols) )
					fprintf('Running KNN...\n\n\n FOLD [%d] \n K[%d]\n\n', k_fold, K);
					fprintf('Valor de beg_row[%d], end_row[%d]\n\n', beg_row, end_row);
					resp_mat = knn( train_data( beg_row:end_row, : ), K );
					knn_fold_file = strcat('knn_fold_', int2str(k_fold), '_KVal_', int2str(K), '.mat') ;
					save( 'knn_fold_file', 'resp_mat' );

					fprintf( 'Salvando arquivo: [%s]\n\n', knn_fold_file );

				end;

			else
				
				fprintf('Running KNN...\n\n\n FOLD [%d] \n K[%d]', k_fold, K);

				resp_mat = knn( train_data( beg_row:end_row, : ), K );
				knn_fold_file = strcat('knn_fold_', int2str(k_fold), '_KVal_', int2str(K), '.mat') ;
				save( 'knn_fold_file', 'resp_mat' );
				fprintf( 'Salvando arquivo: [%s]\n\n', knn_fold_file );
			end;

		end;

	else
		fprintf('Running KNN...\n\n\n');
		resp_mat = knn( train_data, K );
		knn_file = strcat('knn_fold_', int2str(k_fold), '_KVal_', int2str(K), '.mat') ;
		save( 'knn_file', 'resp_mat' );
		fprintf( 'Salvando arquivo: [%s]\n\n', knn_file );
	end;

end