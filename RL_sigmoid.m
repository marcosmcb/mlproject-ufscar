function g = sigmoid(z)
%SIGMOID Calcula a funcao sigmoidal
%   G = SIGMOID(z) calcula a sigmoid de z.

% Variavel de retorno
g = zeros(size(z)); %#ok<*PREALL>

% Calcula a sigmoid de cada valor de z (z pode ser uma matriz,
%               vetor ou escalar).

e = exp(1);

g = 1 ./ (1 + e .^ -z);

end
