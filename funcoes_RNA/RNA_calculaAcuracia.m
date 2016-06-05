function [ acuracia ] = RNA_calculaAcuracia(testData, testTargetData, pesos_InputInterm, pesos_IntermInterm, pesos_IntermOutput)
%
% Classifica a base de teste passada e calcula a acuracia da classificacao
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

% classifica os dados
testDataClassificada = RNA_test(testData, pesos_InputInterm, pesos_IntermInterm, pesos_IntermOutput);

% calcula a que classe pertence cada linha
classesCalculadas = zeros(size(testData, 1), size(testDataClassificada, 2));

for row_n = 1:size(testDataClassificada, 1)
    [~, classIdx] = max(testDataClassificada(row_n, :));
    classesCalculadas(row_n, classIdx) = 1;
end

acuracia = mean( all(classesCalculadas == testTargetData, 2) );

end

