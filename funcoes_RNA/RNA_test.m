function [ output ] = ...
    RNA_test(testData, pesos_InputInterm, pesos_IntermInterm, pesos_IntermOutput)
%
% Classifica a base de teste passada e calcula a acuracia da classificacao
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

output = zeros(size(testData, 1), 5);

for row_n = 1:size(testData, 1)
    a_input = horzcat(1, testData(row_n, :));
    a_interm = horzcat(1, 1 ./ (1 + exp(-a_input * pesos_InputInterm)));
    output(row_n, :) = 1 ./ (1 + exp(-a_interm * pesos_IntermOutput));
end
end

