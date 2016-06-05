function RL_treinar( trainData, nColAlvo, opcaoTreino )
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

%% Treino da base inteira com os melhores parametros

if opcaoTreino == 3
	
	lambda = [ 9 0.125 11 11 0.5 ]; % mudar depois de selecionar o melhor parâmetro (pode ser um vetor de 5 posicoes)
	
	% treina com toda a base 
	[thetas, custo] = RL_principal(trainData, lambda, nColAlvo);
	
	% calcula acuracia
	[acuracias] = RL_calculaResultados(trainData, thetas, nColAlvo);
	
	% salva em arquivo
	nomeArquivo = '.\resultados_RL\parametrosEresultadosTreinoGeral.mat';
	
	save(nomeArquivo, 'lambda', 'thetas', 'custo', 'acuracias');
	
	% imprime os valores encontrados
	fprintf('Acuracias por saida-alvo: ');
	fprintf('%g ', acuracias);
	fprintf('Lambdas por saida-alvo: ');
	fprintf('%g ', lambda);
	
	return;
end


%% Reducao da base e inicializacao dos parametros para Coarse Grid Search

if opcaoTreino == 1 % demorou 3188 segundos para 11 lambdas
	nElemCoarse = ceil(nElem * porCentagem);

	% variaveis sao modificadas apenas no escopo da funcao (testado)
	trainData = trainData(1:nElemCoarse,:);
	
	expoenteCoarse = -5:1:5;
	lambdaPart(:,1) = 10.^expoenteCoarse;
	
	lambda = [lambdaPart, lambdaPart, lambdaPart, lambdaPart, lambdaPart ];
	
	[nElem, ~] = size(trainData);

	fprintf('Base reduzida para %g (%g%%) elementos a serem usados na coarse grid search\n', nElem, porCentagem*100);
	
end


%% Inicializacao de parametro para normal grid search

if opcaoTreino == 2 % demorou ~8200 segundos para esse lambda
	% lambda pode ser uma matriz com as colunas sendo um lambda para cada coluna-alvo
	% e as linhas de cada coluna a variação dos lambdas
	
	lambda = [	8 0.05 8 8 0.5 ;...
				9 0.075 9 9 0.75 ;...
				10 0.1 10 10 1 ;...
				11 0.125 11 11 1.25 ;...
				12 0.15 12 12 1.5 ];
end


%% Adição de Atributos Polinomiais

trainData = RL_atributosPolinomiais(trainData, nColAlvo);

[~, nColPol] = size(trainData);

fprintf('Atributos polinomiais adicionados (numero de colunas aumentou de %g para %g)\n', nCol, nColPol);


%% Procedimento principal (n-fold cross validation com grid search)

% quantidade de variacoes de lambdas usados no grid search
[nLinLambdas, ~] = size(lambda);

% alocacao de variaveis
thetas = zeros(qtdeFolds, nLinLambdas, nColPol-nColAlvo, nColAlvo);
custos = zeros(qtdeFolds, nLinLambdas, nColAlvo);

acuracias = zeros(qtdeFolds, nLinLambdas, nColAlvo);
% fmedidas = zeros(qtdeFolds); % estara presente em futuras versoes

tic
% executa os n-folds
for foldAtual = 1:qtdeFolds
	
	fprintf('[RL] Executando Fold: %g | Quantidade de lambdas: %g\n', foldAtual, nLinLambdas);
	
	[trainDataFold, testDataFold] = RL_splitDadosNFold(trainData, qtdeFolds, foldAtual);
	
	% TREINO com [coarse || normal] gridSearch
	for itLambda = 1:nLinLambdas
		fprintf('Lambdas por saida-alvo = ');
		fprintf('%g ', lambda(itLambda, :));
		fprintf('\n');
		
		[thetas(foldAtual, itLambda, :, :), custos(foldAtual, itLambda, :)] = RL_principal(trainDataFold, lambda(itLambda,:), nColAlvo);
		toc
	end
	
	% TESTE (validacao)
	[acuracias(foldAtual, :, :)] = RL_calculaResultados(testDataFold, thetas(foldAtual, :, :, :), nColAlvo);

end


%% Salva resultados em arquivo

if opcaoTreino == 1
	arquivoParametros = '.\resultados_RL\coarse_parametros.mat';
	arquivoResultados = '.\resultados_RL\coarse_resultados.mat';
end

if opcaoTreino == 2
	arquivoParametros = '.\resultados_RL\normal_parametros.mat';
	arquivoResultados = '.\resultados_RL\normal_resultados.mat';
end

save(arquivoParametros, 'thetas', 'custos', 'lambda');
save(arquivoResultados, 'acuracias', 'lambda');


end

