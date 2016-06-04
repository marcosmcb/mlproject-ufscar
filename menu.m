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

	% Numero de colunas-alvo nos dados de treino
	nColAlvo = 5;
	% Guarda a opcao do menu escolhida
	opcaoMenu = 1;
	% Guarda o algoritmo escolhido
	algoritmo = 1;


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

end