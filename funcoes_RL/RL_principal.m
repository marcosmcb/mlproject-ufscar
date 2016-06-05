function [thetas, custo] = RL_principal( trainData, lambda, nColAlvo)
% [thetas, custo] = RL_principal( trainData, lambda, nColAlvo)
%
% Faz a chamada para a otimizacao do gradiente usando os dados de treino e o lambda passados
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis

% numero de thetas e o numero de colunas dos dados (menos as colunas-alvo)
[~, nCol] = size(trainData);
numThetas = nCol - nColAlvo;

% alocacao de variaveis
thetas = zeros(numThetas, nColAlvo);
custo = zeros(1, nColAlvo);

%% Separacao dos dados para treino de cada coluna alvo

% colunas-alvo
targetData = trainData(:, nCol-nColAlvo+1:end);
% demais colunas
trainData = trainData(:, 1:nCol-nColAlvo);

%% Procedimento principal

% Otimiza o gradiente para cada uma das colunas alvo (aprende a classificar)
for colAlvo = 1:nColAlvo
	[theta, RL_custo] = RL_OtimizacaoGradiente(trainData, targetData(:,colAlvo), lambda(colAlvo));
	
	custo(1,colAlvo) = RL_custo; % cada posicao do vetor guarda o custo para uma coluna alvo
	thetas(:,colAlvo) = theta; % cada coluna da matriz guarda um vetor de thetas para uma coluna alvo
	toc
end

end
