function [ trainDataFold, testDataFold ] = RL_splitDadosNFold( trainData, qtdeFolds, foldAtual )
% [ trainDataFold, testDataFold ] = RL_splitDadosNFold( trainData, qtdeFolds, foldAtual )
%
% Recebe uma base de dados (de treino), separa em qtdeFolds partes
% pega uma dessas partes (a foldAtual) como de teste
% e retorna todas menos ela para treino e ela para teste
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis

% numero de amostras na base (linhas)
[nElem, ~] = size(trainData);

% numero de elementos por fold (o ultimo fold vai ter alguns elementos a mais (parte real da divisao))
nElemPorFold = floor(nElem/qtdeFolds);

% posicao do elemento antes do fold atual
posAntesFoldAtual = nElemPorFold*(qtdeFolds-foldAtual);

% posicao do elemento depois do fold atual 
posDepoisFoldAtual = nElemPorFold * (qtdeFolds-foldAtual + 1) + 1;

% posicoes de inicio e fim dos elementos do fold atual
inicioFoldAtual = nElemPorFold * (qtdeFolds-foldAtual) + 1;
fimFoldAtual = nElemPorFold * (qtdeFolds-foldAtual + 1);

%% Separacao

% junta de 1 ate (nElementos / totalFolds-nAtual) mais (nElementos / nElementos - nAtual-1) ate o fim
trainDataFold = [trainData(1 : posAntesFoldAtual , :) ; ...
				 trainData(posDepoisFoldAtual : end , :)];

testDataFold = trainData(inicioFoldAtual : fimFoldAtual, :);

end
