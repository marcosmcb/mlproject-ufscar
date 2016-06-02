function [RL_custoVector, RL_thetaMatrix] = RL_principal( trainData, targetData , RL_lambda, nColAlvo)
% RL_principal( trainData, targetData , RL_lambda, nOutTest)
% Faz a chamada para a otimizacao do gradiente usando a regressao linear
%
% trainData : dados usados para o treino do classificador
% targetData : dados-alvo da regressao logistica
% RL_lambda : valor do lambda usado na funcao
% nOutTest : numero de colunas alvo nos dados-alvo
%
% code by Rocchi™

%% Procedimentos
fprintf('RL - Otimizando gradiente para lambda = %g, com numColunasAlvo = %d\n', RL_lambda, nColAlvo);

[~, numThetas] = size(trainData); % numero de thetas e o numero de colunas dos dados

% variaveis para salvar em arquivo
RL_thetaMatrix = zeros(numThetas, nColAlvo);
RL_custoVector = zeros(1, nColAlvo);

for iAlvo = 1:nColAlvo
	[RL_theta, RL_custo] = RL_OtimizacaoGradiente(trainData, targetData(:,iAlvo), RL_lambda);
	
	RL_custoVector(1,iAlvo) = RL_custo; % cada posicao do vetor guarda o custo para uma coluna alvo
	RL_thetaMatrix(:,iAlvo) = RL_theta; % cada coluna da matriz guarda um vetor de thetas para uma coluna alvo
end

end
