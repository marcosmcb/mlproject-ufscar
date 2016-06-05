function RL_melhorAcuraciaGeral( acuracias, lambda )
% RL_melhorAcuraciaGeral( acuracias, lambda )
%
% Calcula a acuracia por coluna e acuracia media
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis

[~, nAcuracias] = size(acuracias);


%% Imprime as acuracias por coluna

fprintf('Acuracias por saida-alvo: ');
fprintf('%g ', acuracias);
fprintf('\n');
fprintf('Lambdas por saida-alvo: ');
fprintf('%g ', lambda);
fprintf('\n');


%% Imprime a acuracia media
fprintf('\nAcuracia media: %g\n', sum(acuracias)/nAcuracias);


% sucesso muleke
end

