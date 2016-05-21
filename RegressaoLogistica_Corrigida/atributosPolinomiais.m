function out = atributosPolinomiais(X1, X2)
% ATRIBUTOS POLINOMIAIS Gera atributos polinomiais a partir dos atriburos
% originais da base
%
%   ATRIBUTOSPOLINOMIAIS(X1, X2) mapeia os dois atributos de entrada
%   para atributos quadraticos
%
%   Retorna um novo vetor de mais atributos:
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   As entradas X1, X2 devem ser do mesmo tamanho
%

grau = 6;
out = ones(size(X1(:,1)));
for i = 1:grau
    for j = 0:i
        out(:, end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end