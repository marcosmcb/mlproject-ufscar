function [ trainDataFold, testDataFold ] = RNA_splitDadosNFold( trainData, qtdeFolds, foldAtual )

%% Variaveis

% numero de amostras na base (linhas)
[nElem, ~] = size(trainData);

% numero de elementos por fold (o ultimo fold vai ter alguns elementos a mais (parte real da divisao))
nElemPorFold = floor(nElem / qtdeFolds);

% posicao do elemento antes do fold atual
posAntesFoldAtual = nElemPorFold * (qtdeFolds - foldAtual);

% posicao do elemento depois do fold atual 
posDepoisFoldAtual = nElemPorFold * (qtdeFolds - foldAtual + 1) + 1;

% posicoes de inicio e fim dos elementos do fold atual
inicioFoldAtual = nElemPorFold * (qtdeFolds - foldAtual) + 1;
fimFoldAtual = nElemPorFold * (qtdeFolds - foldAtual + 1);

%% Separacao

% junta de 1 ate (nElementos / totalFolds-nAtual) mais (nElementos / nElementos - nAtual-1) ate o fim
trainDataFold = [trainData(1:posAntesFoldAtual , :) ; ...
				 trainData(posDepoisFoldAtual:end , :)];

testDataFold = trainData(inicioFoldAtual:fimFoldAtual, :);

end
