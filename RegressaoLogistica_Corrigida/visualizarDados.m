function visualizarDados(X, Y)
%VIZUALIZARDADOS Plota as amostras X de acordo com as classe em Y 
%em uma nova figura
%   VIZUALIZARDADOS(X,Y) plota os exemplos positivos como sinais '+' e os
%   os exemplos negativos como sinais 'o'. Assume-se que X eh uma matriz
%   Mx2.

% Cria uma nova figura
figure; hold on;

% Plota exemplos das classes positivas e negativas em um plot 2D, usando
% a opcao 'k+' para exemplos positivos e 'ko' para os negativos

% Encontra os indices das amostras positivas (pos) e negativas (neg)
pos = find(Y==1); neg = find(Y == 0);

% Plota as amostras
plot(X(pos, 1), X(pos, 2), 'b+','LineWidth', 2, 'MarkerSize', 7);
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 7);

hold off;

end
