function KNN_submenu( trainData, testData, nColAlvo, opcaoMenu )
% KNN_submenu( trainData, testData, nColAlvo, opcaoMenu )
%
% Faz chamadas de funcoes das operacoes do KNN
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%{
Estrutura do submenu

	Faz operacoes com os dados se necessario

	if opcao == TREINAR

	if opcao == AVALIAR

	if opcao == CLASSIFICAR

%}

%% Variaveis

%% Operacoes com os dados

%% Treinar
if opcaoMenu == 1
	KNN_treinar(trainData, nColAlvo);
end

%% Avaliar
if opcaoMenu == 2
	KNN_avaliar(trainData, nColAlvo);
end

%% Testar
if opcaoMenu == 3
	KNN_classificar(testData);
end




%% Codigo antigo
%{
    resp = input('\nDeseja rodar 10-fold cross validation? [ 1-Sim 0-Nao ]\n> ');

    num_fold = 10;
	resp_grid = 0;
    K = 11; % default value when grid-search is not selected
	
	[~, ~, ~] = mkdir('resultados_KNN');

	if resp
		
		[ nRows, nCols ] = size( trainData );
		elementsInFold = ceil( nRows / num_fold );
		
		for k_fold=1:num_fold
			
			beg_row = ((k_fold-1) * elementsInFold)+1;
			end_row =  k_fold * elementsInFold;

			if k_fold == num_fold
				end_row = nRows;
			end;

			if resp_grid == 0;
				resp_grid = input('Deseja rodar grid-search? [ 1-Sim 0-Nao ]\n> ');
			end;
			tic
			
			if resp_grid

				% We only get even values because our number of classes is odd. So, we don't get a draw
				for K_idx = 1:2:ceil( sqrt(nCols) + 1)
					fprintf('Running KNN...\n\n\nFOLD [%d]\tK[%d]\n', k_fold, K_idx);
					fprintf('Valor de beg_row[%d], end_row[%d]\n', beg_row, end_row);
					true_classes = trainData( beg_row:end_row, end-4:end );
					resp_mat = knn( trainData( beg_row:end_row, : ), K_idx );

					% Preparing result to be evaluated
					normalized_result = normalizeKNNResult( resp_mat );
					[ right_instances, percentage ] = evaluateKNN( normalized_result, true_classes );
					fprintf( 'Resultado da Avaliacao do KNN com K = [%d] eh: Acertos[%d] / Total[%d] - Percentage [%f] \n', K_idx, right_instances, size(normalized_result,1), percentage );

					knn_fold_file = strcat('./KNN_results/knn_foldAndGrid_', int2str(k_fold), '_KVal_', int2str(K_idx), '.mat') ;
					save( knn_fold_file, 'resp_mat' );

					fprintf( 'Salvando arquivo: [%s]\n', knn_fold_file );
					
					toc;
				end;

			else
				
				fprintf('Running KNN...\n\n\n FOLD [%d] \n K[%d]', k_fold, K);

				resp_mat = knn( trainData( beg_row:end_row, : ), K );
				
				% Preparing result to be evaluated
				true_classes = trainData( beg_row:end_row, end-4:end );
				normalized_result = normalizeKNNResult( resp_mat );
				[ right_instances, percentage ] = evaluateKNN( normalized_result, true_classes );
				fprintf( 'Resultado da Avaliacao do KNN com K = [%d] eh: Acertos[%d] / Total[%d] - Percentage [%f] \n', K, right_instances, size(normalized_result,1), percentage );

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
		
		resp_mat = knn( trainData, K );
		
		% Preparing result to be evaluated
		true_classes = trainData( :, end-4:end );
		normalized_result = normalizeKNNResult( resp_mat );
		[ right_instances, percentage ] = evaluateKNN( normalized_result, true_classes );
		fprintf( 'Resultado da Avaliacao do KNN com K = [%d] eh: Acertos[%d] / Total[%d] - Percentage [%f] \n', K, right_instances, size(normalized_result,1), percentage );

		knn_file = strcat('./KNN_results/knn_simple_KVal_', int2str(K), '.mat') ;
		save( knn_file, 'resp_mat' );
		fprintf( 'Salvando arquivo: [%s]\n\n', knn_file );
		
		toc
	end;
%}
end
