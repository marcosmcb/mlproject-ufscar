function RL_melhorAcuraciaGridSearch( acuracias, lambda )
% RL_melhorAcuraciaGridSearch( acuracias, lambda )
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

for iFold = 1:nFolds
	for iLambda = 1:nLambdas
		for iColAlvo = 1:nColAlvo
			acuraciaMediaPorFold(iLambda, iColAlvo) = acuraciaMediaPorFold(iLambda, iColAlvo) + (acuracias(iFold, iLambda, iColAlvo) / nFolds);
		end
	end
end


%% Calcula a melhor acuracia

for iLambda = 1:nLambdas
	for iColAlvo = 1:nColAlvo
		if acuraciaMediaPorFold(iLambda, iColAlvo) > melhorAcuracia(iColAlvo)
			melhorAcuracia(iColAlvo) = acuraciaMediaPorFold(iLambda, iColAlvo);
			melhorLambda(iColAlvo) = iLambda;
		end
	end
end


%% Imprime o melhor resultado encontrado

fprintf('Melhor acuracia encontrada (por saida-alvo): ');
fprintf('%g ', melhorAcuracia);
fprintf('\nMelhor lambda por saida-alvo: ');
for i = 1:nColAlvo
	fprintf('%g ', lambda(melhorLambda(i),i));
end
fprintf('\n');


end

