function RL_gridSearch( trainData, targetData, execCGS, nColAlvo, nFold)
% RL_init (data, execCoarse, execGrid)
% Faz as operacoes iniciais da regressao logistica
%
% trainData : sao os dados de treino
% targetData : sao os dados-alvo
% execCGS : flag, ativa executa coarsegridsearch, normalgridsearch caso contrario
% nColAlvo : especifica quantas colunas ao final de 'data' sao colunas alvo [max=5]
%
% code by Rocchi™


%% Coarse GridSearch

[nAmostras, ~] = size(targetData);

if execCGS == 1
	fprintf('Iniciando Coarse gridSearch\n');

	randomIndex = randperm(nAmostras); % permuta os indices randomicamente
	dezPorCento = floor(nAmostras * 0.1); % pega 10% das amostras para o coarse GS

	% pega 10% randomicos dos dados
	coarseTrainData = trainData(randomIndex(1:dezPorCento),:);
	coarseTargetData = targetData(randomIndex(1:dezPorCento),:);
	
	fprintf('Coarse Grid Search usando %g amostras (10%%) randomicas\n', dezPorCento);

	% resultados Coarse GridSearch
	%{
	Rodando com n-fold cross validation
	[0.0001 0.001 0.01 0.1 1 10 100 1000] = 0.001; 0.001 (rerun)
	
	[0.0005 0.001 0.005 0.01 0.05] = 0.005
	%}
	
	i=1;
	for coarseLambda = [0.0005 0.001 0.005 0.01 0.05] % escolhidos empiricamente para buscar pelo melhor
		[RL_custosVector(:,:,i), RL_thetasMatrix(:,:,i)] = RL_principal(coarseTrainData, coarseTargetData, coarseLambda, nColAlvo);
		RL_lambdas(i) = coarseLambda;
		i = i+1;
	end
		
end

%% Normal Grid Search

if execCGS == 0
	fprintf('Iniciando Grid Search (normal)\n');

	i=1;
	for normalLambda = 0.001:0.001:0.005 % escolhidos depois de testes exaustivos na coarse gridSearch
		[RL_custosVector(:,:,i), RL_thetasMatrix(:,:,i)] = RL_principal(trainData, targetData, normalLambda, nColAlvo);
		RL_lambdas(i) = normalLambda;
		i = i+1;
	end
	
end


%% Salvando dados em arquivo
fprintf('Salvando dados do gridSearch em arquivo (fold=%g)...\n', nFold);

if execCGS % adiciona _coarse ao nome de arquivo
	RL_nomeArquivo = strcat('./RL_results/RL_numFolds', num2str(nFold), '_coarseGS.mat');
else
	RL_nomeArquivo = strcat('./RL_results/RL_numFolds', num2str(nFold), '_normalGS.mat');
end

save(RL_nomeArquivo, 'nFold', 'RL_lambdas', 'RL_custosVector', 'RL_thetasMatrix');
end