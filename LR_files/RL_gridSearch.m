function RL_gridSearch( trainData, targetData, execCGS, nColAlvo)
% RL_init (data, execCoarse, execGrid)
% Faz as operacoes iniciais da regressao logistica
%
% trainData : sao os dados de treino
% targetData : sao os dados-alvo
% execCGS : flag, ativa executa coarsegridsearch, normalgridsearch caso contrario
% nColAlvo : especifica quantas colunas ao final de 'data' sao colunas alvo [max=5]
%
% code by Rocchi™

%% Dados para o Coarse GridSearch

[nAmostras, ~] = size(targetData);

if execCGS == 1
	fprintf('Iniciando Coarse gridSearc\n');

	randomIndex = randperm(nAmostras); % permuta os indices randomicamente
	dezPorCento = floor(nAmostras * 0.1); % pega 10% das amostras para o coarse GS

	% pega 10% randomicos dos dados
	coarseTrainData = trainData(randomIndex(1:dezPorCento),:);
	coarseTargetData = targetData(randomIndex(1:dezPorCento),:);
	
	fprintf('Coarse Grid Search usando %g amostras (10%%) randomicas\n', dezPorCento);

	% Coarse GridSearch
	tic;
	for coarseLambda = [0.01 0.1 0.25 0.5 1 5 10 50 100] % escolhidos empiricamente para buscar pelo melhor
		RL_principal(coarseTrainData, coarseTargetData, coarseLambda, nColAlvo, execCGS);
	end
	fprintf('Tempo de execucao da Coarse gridSearch: \n');
	toc;
	
	fprintf('Fim da Coarse gridSearch\n');
	
end

%% set de variaveis - MUDAR/REMOVER DEPOIS

RL_lambda = 1; % passado para a funcao que otimiza o gradiente (VAI MUDAR NO GRIDSEARCH DEPOIS)
% RL_principal(trainData, targetData, RL_lambda, nOutTest); % REMOVER QUANDO GRIDSEARCH ESTIVER PRONTO

%% FAZENDO O GRID SEARCH

if execCGS == 0
	fprintf('Pulando o gridSearch\n');
	return; % termina a funcao caso execGrid seja 0
	% MUDAR DEPOIS, se for fazer a parte de teste dos resultados aqui
end

%{
for I = 1:2 % variar o lambda
	for J = 1:2 % variar o Romero Brito
		for K = 1:2 % variar a variancia variavel de varios variados
			if 1 == 2
			 fprintf('Grid Search implementado!\n');
			end

			% Chamada da otimizacao
			%RL_principal(trainData, targetData, RL_lambda, nOutTest);

		end 
	end
end
%}

end