function RL_submenu( trainData, testData, nColAlvo, opcaoMenu )
% RL_submenu( trainData, testData, nColAlvo, opcaoMenu )
%
% Faz chamadas de funcoes das operacoes da regressao logistica
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

% cria a pasta para guardar os dados (se ja existir faz nada)
[~, ~, ~] = mkdir('resultados_RL');


%% Treinar
if opcaoMenu == 1
	
	opcaoTreino = 0;
	
	while opcaoTreino < 1 || opcaoTreino > 3
		fprintf('\nExecutar: \n[1] - Coarse Grid Search\n[2] - Normal Grid Search\n[3] - Treino com a base inteira\n');
		opcaoTreino = input('> ');
		
		if opcaoTreino < 1 || opcaoTreino > 3
			fprintf('Opcao invalida\n');
		end
	end
	
	% faz adição de atributos polinomiais, n-fold cross validation, coarse gridSearch ou normal gridSearch
	RL_treinar(trainData, nColAlvo, opcaoTreino);
	
end

%% Avaliar
if opcaoMenu == 2
	RL_avaliar();
end

%% Classificar
if opcaoMenu == 3
	RL_classificar(testData, nColAlvo);
end


end
