function [ trainDataFold, targetDataFold, testDataFold, testTargetDataFold ] = RL_splitDadosNFold( trainData, targetData, totalFolds, nAtual )
% RL_splitDadosNFold( trainData, targetData, totalFolds, nAtual )
%
% trainData : 
% targetData : 
% totalFolds : 
% nAtual : 
% 
% Divide a base em totalFolds partes e retorna:
% train e target para treino (tamanho totalFolds-1)
% test e target para teste (tamanho de 1 fold)
%
% code by Rocchi™

%% Variaveis uteis

% numero de amostras na base (linhas)
[nElementos, ~] = size(targetData);
% numero de elementos por fold
nDataPfold = ceil(nElementos/totalFolds);

%% Separacao

% junta de 1 ate (nElementos / totalFolds-nAtual) mais (nElementos / nElementos - nAtual-1) ate o fim
trainDataFold = [trainData(1 : nDataPfold*(totalFolds-nAtual) ,:) ; trainData(nDataPfold*(totalFolds-(nAtual-1)):end ,:)];
targetDataFold = [targetData(1 : nDataPfold*(totalFolds-nAtual) ,:) ; targetData(nDataPfold*(totalFolds-(nAtual-1)):end ,:)];

% pega somente a nAtual parte da base
testDataFold = trainData(nDataPfold*(totalFolds-nAtual)+1 : nDataPfold*(totalFolds-nAtual+1)-1, :);
testTargetDataFold = targetData(nDataPfold*(totalFolds-nAtual)+1 : nDataPfold*(totalFolds-nAtual+1)-1, :);

end
