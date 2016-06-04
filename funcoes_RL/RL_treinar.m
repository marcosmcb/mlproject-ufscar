function RL_treinar( trainData, nColAlvo, tipoGridSearch )
% RL_treinar( trainData, nColAlvo, tipoGridSearch )
%
% Faz o treinamento da Regressao Logistica usando n-fold cross validation e grid search
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

% quantidade de folds (n do n-fold)
qtdeFolds = 10;

% porcentagem dos dados usados na coarse grid search
porCentagem = 100/(qtdeFolds*100);


%% Reducao da base e inicializacao dos parametros para Coarse Grid Search

if tipoGridSearch == 1
	nElemCoarse = ceil(nElem * porCentagem);

	% variaveis sao modificadas apenas no escopo da funcao (testado)
	trainData = trainData(1:nElemCoarse,:);
	
	expoenteCoarse = -5:1:5;
	lambda = 10.^expoenteCoarse;
	
	[nElem, ~] = size(trainData);

	fprintf('Base reduzida para %g (%g%%) elementos a serem usados na coarse grid search\n', nElem, porCentagem*100);
	
end


%% Inicializacao de parametro para normal grid search

if tipoGridSearch == 2
	lambda = -1:0.1:1; % mudar depois de executar a coarse grid search (afinar)
end


%% Adição de Atributos Polinomiais

trainData = RL_atributosPolinomiais(trainData, nColAlvo);

[~, nColPol] = size(trainData);

fprintf('Atributos polinomiais adicionados (numero de colunas aumentou de %g para %g)\n', nCol, nColPol);


%% Procedimento principal (n-fold cross validation com grid search)

% quantidade de lambdas usados no grid search
[~, nLambdas] = size(lambda);

% alocacao de variaveis
thetas = zeros(qtdeFolds, nLambdas, nColPol-nColAlvo, nColAlvo);
custos = zeros(qtdeFolds, nLambdas, nColAlvo);

acuracias = zeros(qtdeFolds, nLambdas, nColAlvo);
% fmedidas = zeros(qtdeFolds); % estara presente em futuras versoes

tic
% executa os n-folds
for foldAtual = 1:qtdeFolds
	
	fprintf('[RL] Executando Fold: %g | Quantidade de lambdas: %g\n', foldAtual, nLambdas);
	
	[trainDataFold, testDataFold] = RL_splitDadosNFold(trainData, qtdeFolds, foldAtual);
	
	% TREINO com [coarse || normal] gridSearch
	i = 0; % iterador
	for itLambda = lambda
		i = i + 1;
		%[thetas(foldAtual, i, :, :), custos(foldAtual, i, :)] = RL_principal(trainDataFold, itLambda, nColAlvo);
		toc
	end
	
	% TESTE (validacao)
	[acuracias(foldAtual, :)] = RL_calculaResultados(testDataFold, thetas(foldAtual, :, :, :), nColAlvo);

end


%% Salva resultados em arquivo

if tipoGridSearch == 1
	arquivoParametros = './resultados_RL/coarse_parametros.mat';
	arquivoResultados = './resultados_RL/coarse_resultados.mat';
end

if tipoGridSearch == 2
	arquivoParametros = './resultados_RL/normal_parametros.mat';
	arquivoResultados = './resultados_RL/normal_resultados.mat';
end

save(arquivoParametros, 'thetas', 'custos', 'lambda');
save(arquivoResultados, 'acuracias', 'lambda');


end

