function g = sigmoid(z)
%SIGMOID Calcula a funcao sigmoidal
%   G = SIGMOID(z) calcula a sigmoid de z.

% Voce precisa retornar a seguinte variavel corretamente
g = zeros(size(z));

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule a sigmoid de cada valor de z (z pode ser uma matriz,
%               vetor ou escalar).

z = -z;
e = exp(1);

g = 1 ./ (1 + e .^ z);

% =======================================================================

end
