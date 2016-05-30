function [y, ind_viz] = knn_calc(x, X, Y, K)
%KNN m�todo do K-vizinhos mais proximos para predizer a classe de um novo
%   dado.

%  Inicializa a variavel de retorno e algumas variaveis uteis
y = -1;                % Inicializa rotulo como classe negativa
ind_viz = ones(K,1);  % Inicializa indices (linhas) em X das K amostras mais 
                      % proximas de x.
                      
[m, ~] = size(X);

D = zeros(m,2);
for i=1:m
    D(i,1) = manhattan_dist(x, X(i,:));
end
D(:,2) = Y;

D = sortrows(D, 1);

y = mode(D(1:K,2));

% =========================================================================

end