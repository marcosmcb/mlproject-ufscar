function [ RL_AP_matriz ] = RL_atributosPolinomiais( trainData , colReal)
% RL_atributosPolinomiais( trainData , colReal)
% trainData : base de dados para gerar os atributos polinomiais
% colReal : indice da coluna com valores reais possiveis de serem exponenciados (idade)
%
% Recebe a base e aplica AND nas colunas binarias para gerar combinacoes
% E junta com colunas de exponenciacoes da coluna real (idade)
%
% code by Rocchi™

%% Variaveis necessarias

[nLinhas, nColunas] = size(trainData);

nColBin = nColunas - 1; % menos a coluna Real

matrizReal = zeros(nLinhas, 3);

matrizBin = zeros(nLinhas, nColBin*2);

%% Separacao das colunas

% matriz para as operacoes de binario
binTrainData = [trainData(:,1:(colReal-1)), trainData(:,(colReal+1:end))];

% coluna dos valores reais
realTrainCol = trainData(:,colReal);

%% Polinomiarizacao

% coluna real exponenciada a 2, 3 e 4
matrizReal = [realTrainCol.^2, realTrainCol.^3, realTrainCol.^4];

% combinacoes(AND) em pares de colunas binarias subsequentes
for i = 1:(nColBin-1)
	matrizBin(:,i) = binTrainData(:,i) & binTrainData(:,i+1);
end
matrizBin(:,nColBin) = binTrainData(:,nColBin) & binTrainData(:,1); % combina a ultima com a primeira

% combinacoesem(AND) em pares de colunas binarias em ordem randomica
randomIndex = randperm(nColBin); % permuta os indices randomicamente
for i = 1:(nColBin-1)
	matrizBin(:,i+nColBin) = binTrainData(:,randomIndex(i)) & binTrainData(:,randomIndex(i+1));
end
matrizBin(:,nColBin*2) = binTrainData(:,randomIndex(end)) & binTrainData(:,randomIndex(1)); % combina a ultima com a primeira

	
%% Juncao para retorno

RL_AP_matriz = [matrizBin, matrizReal];

%% Secao de testes
%{
fprintf('mostrando tamanhanho resultante das matrizes binaria, real, e total:\n');
disp(size(matrizReal));
disp(size(matrizBin));
disp(size(RL_AP_matriz));
fprintf('enter para continuar\n');
pause;
%}

end
