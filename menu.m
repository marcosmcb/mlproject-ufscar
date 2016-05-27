function menu( train_data, test_data )
% menu( train_data, train_dataset_normalized )
% Lista opcoes para executar cada parte do projeto
    
    fprintf(' Exibindo menu das operacoes sobre a base de dados \n\n');
	
%% Estatisticas sobre os dados
    resp = input('Deseja Visualizar estatisticas sobre os dados ? [ 1-Sim 0-Nao ]\n');

    if ( resp ) 

        fprintf( 'Estatisticas sendo executadas sobre a base de dados original \n' );
        getStatistics( train_data );

    end;
	

%% Normalizacao dos dados
	resp = 0;
	isThereProcessedData = exist('processed_data.mat', 'file');
	
	% se existem dados em arquivo, da a opcao de carregar
	if isThereProcessedData
		resp = input('Dados processados encontrados em arquivo, carregar? [ 1-Sim 0-Nao ]\n');
		
		if resp % caso selecione carregar
			load('processed_data.mat');
		end
	end
	
	% se nao roda o processamento dos dados novamente / caso selecione nao carregar na opcao anterior
	if ~isThereProcessedData || ~resp
		
		if ~isThereProcessedData
			fprintf('Dados processados nao encontrados em arquivo, executando processamento...\n');
		else
			fprintf('Reprocessando dados... (Tempo aproximado 20s)\n');
		end
		
		tic;
		[ train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed ] = normalizeDataset( train_data );
		fprintf('Tempo gasto com o processamento:\n');
		toc;
	end
	
	
%% KNN
    resp = input('\nDeseja executar o algoritmo KNN? [ 1-Sim 0-Nao ]\n');

    if ( resp )
		
		% chama knn() { ele roda e salva em arquivo os resultados}

        resp = input('Deseja visulizar os dados gerados pelo KNN? [1-Sim 0-Nao]\n');
        
        if( resp ) % carrega os dados e calcula a acuracia (?)

        end;

    end;


%% Regressao Logistica
    resp = input('\nDeseja executar o algoritmo Regressao Logistica? [ 1-Sim 0-Nao ]\n');

    if ( resp ) % Regressao Logistica
		
		% trocar pra input() as entradas extras (?)
		RL_init(train_dataset_normalized, 1, 0, 5); % coarseGrid, gridSearch, nColAlvo

        resp = input('Deseja visulizar os dados gerados pela Regressao Logistica? [1-Sim 0-Nao]\n');
        
        if( resp )
			% RL_results(); % separa o treino do calculo da acuracia
        end;

    end;

	
%% SVM
    resp = input('\nDeseja executar o algoritmo SVM? [ 1-Sim 0-Nao ]\n');

    if ( resp )
		
		SVM_init(train_dataset_normalized);

        resp = input('Deseja visulizar os dados gerados pela SVM? [1-Sim 0-Nao]\n');
        
        if( resp )

        end;

    end;
    
	
%% Redes Neurais Artificiais
    resp = input('\nDeseja executar o algoritmo Rede Neural Artificial? [ 1-Sim 0-Nao ]\n');

    if ( resp )

        resp = input('Deseja visulizar os dados gerados pela Rede Neural Artificial? [1-Sim 0-Nao]\n');
        
        if( resp )

        end;

    end;

end