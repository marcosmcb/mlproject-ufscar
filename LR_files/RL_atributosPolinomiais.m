function [ RL_AP_matriz ] = RL_atributosPolinomiais( trainData , colReal)
% RL_atributosPolinomiais( trainData , colReal)
% trainData : base de dados para gerar os atributos polinomiais
% colReal : indice da coluna com valores reais possiveis de serem exponenciados (idade)
%
% Recebe a base e aplica AND nas colunas binarias para gerar combinacoes
% Junta com colunas de exponenciacoes da coluna real (idade)
%
% Retorna a base original mais as colunas criadas
%
% code by Rocchi™

%% Variaveis uteis

[nLinhas, nColunas] = size(trainData);

nColBin = nColunas - 1; % numero de colunas binarias (todas menos a coluna Real)

%% Separacao das colunas

% matriz para as operacoes de binario
binTrainData = [trainData(:,1:(colReal-1)), trainData(:,(colReal+1:end))];

% coluna dos valores reais
realTrainCol = trainData(:,colReal);

%% Polinomiarizacao

% coluna real exponenciada a 2, 3 e 4
matrizReal = [realTrainCol.^2, realTrainCol.^3, realTrainCol.^4];

% combinacoes (AND) 2 a 2
comb2 = zeros(nLinhas, floor(nColBin/2));

for i = 1:floor(nColBin/2)
	comb2(:,i) = binTrainData(:,(i*2)-1) & binTrainData(:,i*2);
end

% combinacoes (AND) 3 a 3
comb3 = zeros(nLinhas, floor(nColBin/3));

for i = 1:floor(nColBin/3)
	comb3(:,i) = binTrainData(:,(i*3)-2) & binTrainData(:,(i*3)-1) & binTrainData(:,i*3);
end

% combinacoes (AND) 4 a 4
comb4 = zeros(nLinhas, floor(nColBin/4));

for i = 1:floor(nColBin/4)
	comb4(:,i) = binTrainData(:,(i*4)-3) & binTrainData(:,(i*4)-2) & binTrainData(:,(i*4)-1) & binTrainData(:,i*4);
end

	
%% Juncao para retorno

RL_AP_matriz = [trainData, matrizReal, comb2, comb3, comb4];


end
