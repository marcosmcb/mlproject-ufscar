function [ acuracia ] = RL_calculaResultadosGeral( testData, thetas, nColAlvo )
% [ acuracia ] = RL_calculaResultados( testData, thetas, lambda, nColAlvo )
%
% Classifica a base de teste passada e calcula a acuracia da classificacao
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis

% numero de lambdas usados na gridsearch e numero de colunas dos dados para classificar (ultimo parametro == nColAlvo)
[nColTreino, ~] = size(thetas);

acuracia = zeros(1,nColAlvo);


%% Separar as colunas (classificar/validar)

classificar = testData(:, 1:nColTreino);
validar = testData(:, nColTreino+1:end);


%% Classifica e calcula a acuracia

% para cada coluna de saida
for iColAlvo = 1:nColAlvo

	% Classifica as colunas usando os thetas
	dadosClassificados = RL_sigmoid( classificar * thetas(:, iColAlvo) );

	% calcula a que classe pertence
	classesCalculadas = dadosClassificados >= 0.5;

	% calcula a acuracia para a coluna-alvo i
	acuracia(iColAlvo) = mean( double( classesCalculadas == validar(:,iColAlvo) ) );

end


end
