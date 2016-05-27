function RL_principal( trainData, targetData , RL_lambda, nColunasAlvo )
% RL_principal( trainData, targetData , RL_lambda, nOutTest)
% Faz a chamada para a otimizacao do gradiente usando a regressao linear
%
% trainData : dados usados para o treino do classificador
% targetData : dados-alvo da regressao logistica
% RL_lambda : valor do lambda usado na funcao
% nOutTest : numero de colunas alvo nos dados-alvo
%
% code by Rocchi™

fprintf('RL - Otimizando gradiente para lambda = %g, com numColunasAlvo = %d\n', RL_lambda, nColunasAlvo);

[~, numThetas] = size(trainData); % numero de thetas e o numero de colunas dos dados

% variaveis para salvar em arquivo
RL_thetaMatrix = zeros(numThetas, nColunasAlvo);
RL_custoVector = zeros(1, nColunasAlvo);

for iAlvo = 1:nColunasAlvo
	[RL_theta, RL_custo] = RL_OtimizacaoGradiente(trainData, targetData(:,iAlvo), RL_lambda);
	
	RL_custoVector(1,iAlvo) = RL_custo; % cada posicao do vetor guarda o custo para uma coluna alvo
	RL_thetaMatrix(:,iAlvo) = RL_theta; % cada coluna da matriz guarda um vetor de thetas para uma coluna alvo
end

fprintf('Salvando dados do(s) theta(s) otimizado(s) em arquivo para lambda=%d\n', RL_lambda);

RL_nomeArquivo = strcat('./RL_results/RL_lambda_',strrep(num2str(RL_lambda), '.', ''), '.mat');
save(RL_nomeArquivo, 'RL_custoVector', 'RL_thetaMatrix');

end
