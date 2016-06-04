function menu(trainData, testData, nColAlvo)
% menu(trainData, testData)
%
% Lista opcoes para executar cada parte do projeto
%
%
% UFSCar BCC 2016-1 - Aprendizado de Maquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%% Variaveis

% Guarda a opcao do menu escolhida
opcaoMenu = 0;
% Guarda o algoritmo escolhido
algoritmo = 0;


%% Selecao de opcoes

while opcaoMenu ~= 4

	fprintf('\nOpcoes: \n');
	fprintf('[1] - Treinar classificadores\n');
	fprintf('[2] - Avaliar resultado do treino dos classificadores\n');
	fprintf('[3] - Classificar a base de teste (formato Kaggle)\n');
	fprintf('[4] - Sair\n');
	opcaoMenu = input('> ');

	if opcaoMenu == 4 % Sair
		break;
	end

	if opcaoMenu < 1 || opcaoMenu > 4
		fprintf('Opcao Invalida\n');
		continue;
	end
	
	while algoritmo < 1 || algoritmo > 4
		fprintf('\nCom qual algoritmo?\n');
		fprintf('[1] - KNN\n');
		fprintf('[2] - Regressao Logistica\n');
		fprintf('[3] - Redes Neurais\n');
		fprintf('[4] - SVM\n');
		algoritmo = input('> ');
		
		if algoritmo < 1 || algoritmo > 4
			fprintf('Opcao invalida\n');
		end
		
	end
	
	switch algoritmo
		case 1
			KNN_submenu(trainData, testData, nColAlvo, opcaoMenu);

		case 2
			RL_submenu(trainData, testData, nColAlvo, opcaoMenu);

		case 3
			RNA_submenu(trainData, testData, nColAlvo, opcaoMenu);

		case 4
			SVM_submenu(trainData, testData, nColAlvo, opcaoMenu);
	end
	
end


%% codigo antigo
%{


%% Estatisticas sobre os dados
%{
resp = input('Deseja Visualizar estatisticas sobre os dados ? [ 1-Sim 0-Nao ]\n> ');

if ( resp ) 

	fprintf( 'Estatisticas sendo executadas sobre a base de dados original \n' );
	getStatistics( train_data );

end;
%}


nColAlvo = 5; % numero de colunas alvo do dataset (colunas binarias para cada possivel saida)
	
%% KNN
resp = input('\nDeseja executar o algoritmo KNN? [ 1-Sim 0-Nao ]\n> ');

if ( resp )

	% chama o menu do KNN
	tic;
		menu_KNN( train_dataset_normalized, test_dataset_normalized );

end;


%% Regressao Logistica

fprintf('\nRegressao Logistica, opcoes:\n');
fprintf('[1] - Treinar classificador da Regressao Logistica.\n');
fprintf('[0] - Continuar\n');

resp = input('> ');

if ( resp==1 )
	tic;
	RL_submenu( train_dataset_normalized , nColAlvo ); % segundo parametro e o numero de colunas alvo
end;

resp = input('\nClassificar base de teste com o classificador da Regressao Logistica? [ 1-Sim 0-Nao ]\n> ');

if ( resp )
	tic;
	RL_classificar(test_dataset_normalized);
end;


%% SVM
resp = input('\nEntrar no submenu da SVM? [ 1-Sim 0-Nao ]\n> ');

if ( resp )
	tic;
	SVM_submenu(train_dataset_normalized, nColAlvo);
end;

resp = input('\nClassificar base de teste com o classificador da SVM? [ 1-Sim 0-Nao ]\n> ');

if ( resp )
	tic;
	%SVM_classificar(test_dataset_normalized);
end;

	
%% Redes Neurais Artificiais
resp = input('\nDeseja executar o algoritmo Rede Neural Artificial? [ 1-Sim 0-Nao ]\n> ');

if ( resp )

	%resp = input('Deseja visulizar os dados gerados pela Rede Neural Artificial? [1-Sim 0-Nao]\n> ');

	%if( resp )
		RNA_submenu(train_dataset_normalized, nColAlvo);
	%end;

end;
%}

end