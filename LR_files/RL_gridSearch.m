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
	melhor = 10 para: [0.0001 0.001 0.01 0.1 1 10 100 1000]
	melhor = 10 para: [6 7 8 9 10 20 30 40 50]
	melhor = 9.5 para: [9.5 10 11 12 13 14 15]
	melhor = 9.9 para: [9.1 9.2 9.3 9.4 9.5 9.6 9.7 9.8 9.9]
	melhor = 9.875 e 9.25 para : [9.850 9.875 9.900 9.925 9.950]
	resultados indicam que a randomizacao dos dados causa variacao a partir de 1 casa decimal
	talvez menos
	melhor = 100 para: [0.0001 0.001 0.01 0.1 1 10 100 1000],
	melhor = 10 para: [5 10 25 50 100 300 500 1000]
	melhor = 10 para: [5 10 25 50 100 300 500 1000] (rerun)
	melhor = 20 para: [6 7 8 9 10 20 30 40 50]
	melhor = 10 para: [6 7 8 9 10 20 30 40 50] (rerun)
	melhor = 10 para: [5 10 15 20 25]
	melhor = 10 para: [5 10 15 20 25] (rerun)
	melhor = 10 para: [8 9 10 12 13 15 18]
	melhor = 10 para: [8 9 10 12 13 15 18] (rerun)
	melhor = 10.5 para: [9.25 9.5 9.75 10 10.25 10.5 10.75]
	melhor = 10.75 para: [9.25 9.5 9.75 10 10.25 10.5 10.75] (rerun)
	melhor = 10 para: [9.5 10 10.5 10.75 11 1.5]
	melhor = 11 para: [9.5 10 10.5 10.75 11 1.5] (rerun)
	
	RANGE PARA TESTES POSSIVEL: 9.5 - 11.5 PASSO .25
		melhor = 10.25 para esse teste
		melhor = 10.75 no rerun
		melhor = 11.25 no trirun
		melhor = 10.25 no tetrarun
		melhor = 10.00 no pentarun
	
		9.5:0.25:11.5
	
	Rodando de novo com n-fold cross validation
	[0.0001 0.001 0.01 0.1 1 10 100 1000] = 0.001; 0.001
	
	[0.0005 0.001 0.005 0.01 0.05] = 0.005
	
	%}
	
	tic;
	i=1;
	for coarseLambda = [0.0005 0.001 0.005 0.01 0.05] % escolhidos empiricamente para buscar pelo melhor
		[RL_custosVector(:,:,i), RL_thetasMatrix(:,:,i)] = RL_principal(coarseTrainData, coarseTargetData, coarseLambda, nColAlvo);
		RL_lambdas(i) = coarseLambda;
		i = i+1;
	end
	fprintf('Tempo de execucao da Coarse gridSearch: \n');
	toc;
	
end

%% Normal Grid Search

if execCGS == 0
	fprintf('Iniciando Grid Search (normal)\n');

	tic;
	i=1;
	for normalLambda = 0.001:0.001:0.005 % escolhidos depois de testes exaustivos na coarse gridSearch
		[RL_custosVector(:,:,i), RL_thetasMatrix(:,:,i)] = RL_principal(trainData, targetData, normalLambda, nColAlvo, execCGS, nFold);
		RL_lambdas(i) = normalLambda;
		i = i+1;
	end
	fprintf('Tempo de execucao da gridSearch: \n');
	%toc;
	
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