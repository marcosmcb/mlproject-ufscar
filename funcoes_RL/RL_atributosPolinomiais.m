function [ trainDataPolinomial ] = RL_atributosPolinomiais( trainData, nColAlvo )
% RL_atributosPolinomiais( trainData )
% 
% Gera atributos polinomiais usando a base de dados fornecida
% combina as colunas binarias
%
% e etorna a base original mais as colunas criadas
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis 

[nLinhas, nColunas] = size(trainData);

% quantidade de colunas binarias
nColBin = nColunas - nColAlvo - 1;

% numero da coluna real (idade), em caso de mudanca na normalizacao alterar esse valor
colReal = 8;

%% Separacao das colunas

% matriz para as operacoes de binario (sem a coluna real e as colunas-alvo)
binTrainData = [trainData(:,1:(colReal-1)), trainData(:,(colReal+1:nColunas-nColAlvo))];


%% Polinomiarizacao (nenhum resultado no google pra essa palavra, acho que ela nao existe, mas eh bonita)

% combinacoes (AND) 2 a 2
combAnd2 = zeros(nLinhas, floor(nColBin/2));

for i = 1:floor(nColBin/2)
	combAnd2(:,i) = binTrainData(:,(i*2)-1) & binTrainData(:,i*2);
end

% combinacoes (AND) 3 a 3
combAnd3 = zeros(nLinhas, floor(nColBin/3));

for i = 1:floor(nColBin/3)
	combAnd3(:,i) = binTrainData(:,(i*3)-2) & binTrainData(:,(i*3)-1) & binTrainData(:,i*3);
end

% combinacoes (AND) 4 a 4
combAnd4 = zeros(nLinhas, floor(nColBin/4));

for i = 1:floor(nColBin/4)
	combAnd4(:,i) = binTrainData(:,(i*4)-3) & binTrainData(:,(i*4)-2) & binTrainData(:,(i*4)-1) & binTrainData(:,i*4);
end



% combinacoes (OR) 2 a 2
combOr2 = zeros(nLinhas, floor(nColBin/2));

for i = 1:floor(nColBin/2)
	combOr2(:,i) = binTrainData(:,(i*2)-1) | binTrainData(:,i*2);
end

% combinacoes (OR) 3 a 3
combOr3 = zeros(nLinhas, floor(nColBin/3));

for i = 1:floor(nColBin/3)
	combOr3(:,i) = binTrainData(:,(i*3)-2) | binTrainData(:,(i*3)-1) | binTrainData(:,i*3);
end

% combinacoes (OR) 4 a 4
combOr4 = zeros(nLinhas, floor(nColBin/4));

for i = 1:floor(nColBin/4)
	combOr4(:,i) = binTrainData(:,(i*4)-3) | binTrainData(:,(i*4)-2) | binTrainData(:,(i*4)-1) | binTrainData(:,i*4);
end


%% Juncao para retorno

trainDataPolinomial = [trainData(:,1:nColunas-nColAlvo), combAnd2, combAnd3, combAnd4, combOr2, combOr3, combOr4, trainData(:,nColunas-nColAlvo+1:end)];


end
