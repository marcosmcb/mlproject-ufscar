function [trainData, testData] = readData( )
% readData()
%
% Simplesmente le os arquivos de dados originais do Kaggle e armazena em memoria
%
%
% UFSCar BCC 2016-1 - Aprendizado de Maquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

trainArq = fopen(fullfile('./dados_originais', 'train.csv'));
trainData = textscan( trainArq, '%s%s%s%s%s%s%s%s%s%s', 'delimiter', ',', 'headerlines', 1);

testArq = fopen(fullfile('./dados_originais', 'test.csv'));
testData = textscan( testArq, '%s%s%s%s%s%s%s%s', 'delimiter', ',', 'headerlines', 1);

end
