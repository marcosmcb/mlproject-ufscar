function [ acuracia ] = RL_calculaResultados( evalData, targetData, thetas, nColAlvo )
% RL_calculaResultados( trainData, targetData, thetas, nColAlvo )
% 
% evalData : dados para avaliar
% targetData : dados alvo para comparar
% thetas : valor dos pesos para cada coluna de eval
% nColAlvo : numero de colunas alvo (colunas de targetData)
% 
% Calcula a acuracia da regressao logistica usando os dados e thetas fornecidos
% e salva os resultados obtidos em arquivo
%
% code by Rocchi™

%% Calcula as classes

evalResults = RL_sigmoid(evalData * thetas);


%% Verifica as classes

acuracia = zeros(nColAlvo,1);

% para cada coluna de saida
for i = 1:nColAlvo
	% calcula a que classe pertence
	classResults = evalResults(:,i) >= 0.5;

	% calcula a acuracia para a coluna-alvo i
	acuracia(i) = mean( double( classResults == targetData(:,i) ) );
	
end

end

