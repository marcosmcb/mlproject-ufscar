function RL_treinar( trainData, nColAlvo, tipoGridSearch )
%
% Faz o treinamento da Rede Neural Artificial usando n-fold cross validation e grid search
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%% Inicializacao dos dados

[nLin, nCol] = size(trainData);

numFolds = 10; % numero de folds da cross validation

maiorAcuracia = 0;

% range dos atributos que serão variados no grid search
% variar neuronios de (num_col_in + num_col_out) / 2) até (2 * num_col_in)
minNeurs = size(trainData, 2) / 2;
maxNeurs = (size(trainData, 2) - 5) * 2;
stepSizeNeurs = round(0.2 * (maxNeurs - minNeurs));

possibleNumNeurs = zeros(6);
for i = 1 : 6
    possibleNumNeurs(i) = ceil(minNeurs) + (i - 1) * stepSizeNeurs;
end

%possibleLearningRates = [0.1; 0.01; ];%0.001;]; %0.0001; 0.00001;];

possibleNumEpochs = [10; 100; 1000;];

% apagar arquivos antigos
if tipoGridSearch == 1
    gridSearchName = 'coarse';
    delete('./resultados_RNA/*_coarseGS.mat');
end
if tipoGridSearch == 2
    gridSearchName = 'normal';
    delete('./resultados_RNA/*_normalGS.mat');
end


%% Reducao da base e inicializacao dos parametros para Coarse Grid Search
if tipoGridSearch == 1
    nElemCoarse = ceil(nLin / numFolds);
    
    trainData = trainData(1:nElemCoarse, :);
    
    fprintf('Base reduzida para %g (%g%%) elementos a serem usados no coarse grid search\n', nElemCoarse, nElemCoarse / nLin * 100);
    
    [nLin, ~] = size(trainData);

end

%% Procedimento principal (n-fold cross validation com grid search)
% executa os n-folds
for foldAtual = 1:numFolds

	[trainDataFold, testDataFold] = RNA_splitDadosNFold(trainData, numFolds, foldAtual);
    
    trainTargetDataFold = trainDataFold(:, size(trainDataFold, 2) - 4:size(trainDataFold, 2)); % treino, colunas output desejado
    trainDataFold = trainDataFold(:, 1:size(trainDataFold, 2) - 5); % treino, colunas input
    
    testTargetDataFold = testDataFold(:, size(testDataFold, 2) - 4:size(testDataFold, 2)); % teste, colunas output desejado
    testDataFold = testDataFold(:, 1:size(testDataFold, 2) - 5); % teste, colunas input
    
    % TREINO
    for neursIdx = 1 : size(possibleNumNeurs)
        %for learningRateIdx = 1 : size(possibleLearningRates)
            for epochIdx = 1 : size(possibleNumEpochs)
                
                fprintf('[RNA] Executando Fold: %g | Neurônios: %g |  Épocas: %g\n', ...
                        foldAtual, possibleNumNeurs(neursIdx), possibleNumEpochs(epochIdx));
%                         foldAtual, possibleNumNeurs(neursIdx), possibleLearningRates(learningRateIdx), possibleNumEpochs(epochIdx));
tic
                [RNA_pesos_InputInterm, RNA_pesos_IntermInterm, RNA_pesos_IntermOutput] = ...
                    RNA_create(trainDataFold, trainTargetDataFold, possibleNumNeurs(neursIdx), possibleNumEpochs(epochIdx));
%                                 possibleLearningRates(learningRateIdx), possibleNumEpochs(epochIdx));
                 
                acuracia = RNA_calculaAcuracia(testDataFold, testTargetDataFold, ...
                                                RNA_pesos_InputInterm, RNA_pesos_IntermInterm, RNA_pesos_IntermOutput);
                if acuracia > maiorAcuracia
                    maiorAcuracia = acuracia;
                    melhorPeso_InputInterm = RNA_pesos_InputInterm;
                    melhorPeso_IntermInterm = RNA_pesos_IntermInterm;
                    melhorPeso_IntermOutput = RNA_pesos_IntermOutput;
                end

                fprintf('Acurácia = %g\n\n', acuracia);

                RNA_nomeArquivo = strcat('./resultados_RNA/RNA_fold', num2str(foldAtual), ...
                                        '_', num2str(possibleNumNeurs(neursIdx)), 'neurs_', ...
                                        num2str(possibleNumEpochs(epochIdx)), 'epocas_', ...
                                        gridSearchName, 'GS.mat')
                save(RNA_nomeArquivo, 'RNA_pesos_InputInterm', 'RNA_pesos_IntermInterm', 'RNA_pesos_IntermOutput', 'acuracia');

                clear RNA_pesos_InputInterm RNA_pesos_IntermInterm RNA_pesos_IntermOutput;
toc
            end
        %end
    end
    
    save(strcat('.resultados_RNA/', gridSearchName, 'GS.mat'), ...
            'melhorPeso_InputInterm', 'melhorPeso_IntermInterm', 'melhorPeso_IntermOutput', 'acuracia');
    

	% TREINO com [coarse || normal] gridSearch
	%for itLambda = lambda
	%	[thetas(foldAtual, itLambda, :), custos(foldAtual, itLambda)] = RL_principal(trainDataFold, itLambda, nColAlvo);
	%end
	
	% TESTE (validacao)
	%[acuracias(foldAtual), fmedidas(foldAtual)] = RL_calculaResultados(testDataFold, thetas(foldAtual), lambda, nColAlvo);

end

