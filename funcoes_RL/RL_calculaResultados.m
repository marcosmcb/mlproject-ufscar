function [ acuracia ] = RL_calculaResultados( testData, thetas, nColAlvo )
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
[~, nLambdas, nCol, ~] = size(thetas);

acuracia = zeros(nLambdas, nColAlvo);


%% Separar as colunas (classificar/validar)

classificar = testData(:, 1:nCol);
validar = testData(:, nCol+1:end);


%% Classifica e calcula a acuracia para cada lambda
for iLambda = 1:nLambdas

	% para cada coluna de saida
	for iColAlvo = 1:nColAlvo
		
		% Classifica as colunas usando os thetas
		dadosClassificados = RL_sigmoid( classificar * squeeze(thetas(1, iLambda, :, iColAlvo)) );

		% calcula a que classe pertence
		classesCalculadas = dadosClassificados(:,iColAlvo) >= 0.5;

		% calcula a acuracia para a coluna-alvo i
		acuracia(iLambda, iColAlvo) = mean( double( classesCalculadas == validar(:,iColAlvo) ) );

	end
	
end


end
