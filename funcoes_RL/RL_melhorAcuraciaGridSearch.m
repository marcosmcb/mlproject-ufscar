function RL_melhorAcuraciaGridSearch( acuracias, lambda )
% RL_melhorAcuraciaGridSearch( acuracias )
% 
% Calcula a melhor acuracia e imprime na tela
% por enquanto eh chamada na linha de comando
% mas pode ser adicionada em algum lugar do codigo principal futuramente
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%% Variaveis 

[nFolds, nLambdas, nColAlvo] = size(acuracias);

melhorAcuracia = zeros(1, nColAlvo);
melhorLambda = zeros(1, nColAlvo);

acuraciaMediaPorFold = zeros(nLambdas, nColAlvo);


%% Calcula a acuracia media por fold

for iFolds = 1:nFolds
	for iLambda = 1:nLambdas
		acuraciaMediaPorFold(iLambda, :) = acuraciaMediaPorFold(iLambda, :) + (acuracias(iFold, iLambda, :) ./ nFolds);
	end
end


%% Calcula a melhor acuracia

for iLambda = 1:nLambdas
	for iColAlvo = 1:nColAlvo
		if acuraciaMediaPorFold(iLambda, :) > melhorAcuracia(iColAlvo)
			melhorAcuracia(iColAlvo) = acuraciaMediaPorFold(iLambda, :);
			melhorLambda(iColAlvo) = iLambda;
		end
	end
end


%% Imprime o melhor resultado encontrado

fprintf('Melhor acuracia encontrada (por saida-alvo): ');
fprintf('%g ', melhorAcuracia);
fprintf('\nlambda por saida-alvo: ');
fprintf('%g ', lambda(melhorLambda));
fprintf('\n');


end

