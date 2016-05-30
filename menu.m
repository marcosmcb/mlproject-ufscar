function menu( train_data, test_data )
% menu( train_data, train_dataset_normalized )
% Lista opcoes para executar cada parte do projeto

%% Esquema possivel do menu
%{
	// definicao: ASK = oferecer opcao pro usuario opcoes e receber resposta dele
	primeiro ASK : fornecer info estatistica dos dados (originais) (que ja esta implementado)
	segundo ASK : opcao de (re)fazer a normalizacao dos dados
		se sim refaz e salva em arquivo
		se nao carrega dos arquivos salvos
		// pode usar uma variavel pra dizer se existem dados salvos ou nao (mesmo esquema de ED2)
		// FUNCAO exist() do matlab faz isto (diferentes retornos inteiros, checa na doc do mathworks os retornos)

	terceiro ASK : rodar treinamento dos classificadores OU rodar teste com parametros salvos em arquivo
		aqui que ou demora meses pra rodar os treinamentos (com submenus pra caso queira rodar so um ou outro)
		ou roda os testes com os parametros e mostra os resultados, graficos e et cætera

	quarto ASK : plotar o que puder? ou plota no 3º ASK já...
		// usar PCA? --> possivel
%}
    
    fprintf(' Exibindo menu das operacoes sobre a base de dados \n\n');
	
%% Estatisticas sobre os dados
    resp = input('Deseja Visualizar estatisticas sobre os dados ? [ 1-Sim 0-Nao ]\n> ');

    if ( resp ) 

        fprintf( 'Estatisticas sendo executadas sobre a base de dados original \n' );
        getStatistics( train_data );

    end;
	

%% Normalizacao dos dados
	resp = 0;
	isThereProcessedData = exist('processed_data.mat', 'file');
	
	% se existem dados em arquivo, da a opcao de carregar
	if isThereProcessedData
		resp = input('Bases de Dados processados encontrados em arquivo, carregar? [ 1-Sim 0-Nao ]\n> ');
		
		if resp % caso selecione carregar
			load('processed_data.mat');
			fprintf('Dados carregados.\n');
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
		% NOTA: coluna de idade pode ou nao estar sendo normalizada por padronizacao, checar se necessario
		[ train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed ] = normalizeDataset( train_data );
		
		fprintf('Tempo gasto com o processamento:\n');
		toc;
	end
	
	nColAlvo = 5; % numero de colunas alvo do dataset (colunas binarias para cada possivel saida)
	
%% KNN
    resp = input('\nDeseja executar o algoritmo KNN? [ 1-Sim 0-Nao ]\n> ');

    if ( resp )
		
		% chama o menu do KNN
		tic;
			menu_KNN( train_dataset_normalized, test_data );

    end;


%% Regressao Logistica

	fprintf('\nRegressao Logistica, opcoes:\n');
	fprintf('[1] - Submenu da Regressao Logistica.\n');
	fprintf('[0] - Continuar\n');

    resp = input('> ');

    if ( resp==1 )
		tic;
		RL_submenu( train_dataset_normalized , nColAlvo ); % segundo parametro e o numero de colunas alvo
    end;


%% SVM
    resp = input('\nEntrar no submenu da SVM? [ 1-Sim 0-Nao ]\n> ');

    if ( resp )
		tic;
		SVM_submenu(train_dataset_normalized, nColAlvo);
    end;
    
	
%% Redes Neurais Artificiais
    resp = input('\nDeseja executar o algoritmo Rede Neural Artificial? [ 1-Sim 0-Nao ]\n> ');

    if ( resp )

        resp = input('Deseja visulizar os dados gerados pela Rede Neural Artificial? [1-Sim 0-Nao]\n> ');
        
        if( resp )

        end;

    end;

end