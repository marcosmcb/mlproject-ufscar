function SVM_treinar( trainData, nColAlvo, opcaoTreino )
% SVM_treinar( trainData, nColAlvo )
%
% 
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis

% numero de elementos e de colunas presentes na base de treino
[nElem, nCol] = size(trainData);


%% Reducao da base e inicializacao dos parametros para Coarse Grid Search

if opcaoTreino == 1
	nElemCoarse = ceil(nElem * porCentagem);

	% variaveis sao modificadas apenas no escopo da funcao (testado)
	trainData = trainData(1:nElemCoarse,:);
	
	custo
	gamma
	
	[nElem, ~] = size(trainData);

	fprintf('Base reduzida para %g (%g%%) elementos a serem usados na coarse grid search\n', nElem, porCentagem*100);
	
end


%% Inicializacao de parametro para normal grid search

if opcaoTreino == 2 % demorou ~8200 segundos para esse lambda
	
	%custo
	%lambda
	
end


%% Treino da base inteira com os melhores parametros

if opcaoTreino == 3
	
	return;
end


%% Procedimento principal (n-fold cross validation com grid search)




%% Salva resultados em arquivo




end

