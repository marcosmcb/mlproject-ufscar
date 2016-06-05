function RL_gridSearch( trainData, targetData, execCGS, nColAlvo, nFold)
% RL_init (data, execCoarse, execGrid)
% Faz as operacoes iniciais da regressao logistica
%
% trainData : sao os dados de treino
% targetData : sao os dados-alvo
% execCGS : flag, ativa executa coarsegridsearch, normalgridsearch caso contrario
% nColAlvo : especifica quantas colunas ao final de 'data' sao colunas alvo [max=5]

%% Coarse GridSearch

[nAmostras, ~] = size(targetData);

% variar neuronios de (num_col_in + num_col_out) / 2) até (2 * num_col_in)
minNeurs = (size(trainData, 2) + size(targetData, 2)) / 2;
maxNeurs = size(trainData, 2) * 2;
stepSizeNeurs = round(0.1 * (maxNeurs - minNeurs));

possibleNumNeurs = zeros(10);
for i = 1 : 10
    possibleNumNeurs(i) = i * stepSizeNeurs;
end

possibleLearningRates = [1; 0.1; 0.01; 0.001;]; %0.0001; 0.00001;];

possibleNumEpochs = [10; 100;];% 1000;];

if execCGS == 1
	fprintf('Iniciando Coarse gridSearch\n');

	randomIndex = randperm(nAmostras); % permuta os indices randomicamente
	dezPorCento = floor(nAmostras * 0.1); % pega 10% das amostras para o coarse GS

	% pega 10% randomicos dos dados
	coarseTrainData = trainData(randomIndex(1:dezPorCento),:);
	coarseTargetData = targetData(randomIndex(1:dezPorCento),:);
	
	fprintf('Coarse Grid Search usando %g amostras (10%%) aleatorias\n', dezPorCento);
    
    for neurs = 1 : size(possibleNumNeurs)
        for learningRate = 1 : size(possibleLearningRates)
            for epoch = 1 : size(possibleNumEpochs)
                [RNA_pesos_InputInterm, RNA_pesos_IntermInterm, RNA_pesos_IntermOutput] = RNA_create(coarseTrainData, coarseTargetData, possibleNumNeurs(neurs), possibleLearningRates(learningRate), possibleNumEpochs(epoch));
                RL_nomeArquivo = strcat('./ANN_results/RNA_fold', num2str(nFold), '_', num2str(possibleNumNeurs(neurs)), 'neurs_', num2str(possibleLearningRates(learningRate)), 'txAprend_', num2str(possibleNumEpochs(epoch)), 'epocas_coarseGS.mat')
                save(RL_nomeArquivo, 'nFold', 'RNA_pesos_InputInterm', 'RNA_pesos_IntermInterm', 'RNA_pesos_IntermOutput');
                clear RNA_pesos_InputInterm RNA_pesos_IntermInterm RNA_pesos_IntermOutput;
            end
        end
    end
end

%% Normal Grid Search

if execCGS == 0
	fprintf('Iniciando Grid Search (normal)\n');

	for neurs = 1 : size(possibleNumNeurs)
        for learningRate = 1 : size(possibleLearningRates)
            for epoch = 1 : size(possibleNumEpochs)
                [RNA_pesos_InputInterm, RNA_pesos_IntermInterm, RNA_pesos_IntermOutput] = RNA_create(trainData, targetData, possibleNumNeurs(neurs), possibleLearningRates(learningRate), possibleNumEpochs(epoch));
                RL_nomeArquivo = strcat('./ANN_results/RNA_fold', num2str(nFold), '_', num2str(possibleNumNeurs(neurs)), 'neurs_', num2str(possibleLearningRates(learningRate)), 'txAprend_', num2str(possibleNumEpochs(epoch)), 'epocas_normalGS.mat')
                save(RL_nomeArquivo, 'nFold', 'RNA_pesos_InputInterm', 'RNA_pesos_IntermInterm', 'RNA_pesos_IntermOutput');
                clear RNA_pesos_InputInterm RNA_pesos_IntermInterm RNA_pesos_IntermOutput;
            end
        end
    end
end
end