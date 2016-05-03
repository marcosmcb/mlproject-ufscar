function J = computarCusto(X, y, theta)
%COMPUTARCUSTO Calcula o custo da regressao linear
%   J = COMPUTARCUSTO(X, y, theta) calcula o custo de usar theta como 
%   parametro da regressao linear para ajustar os dados de X e y

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento

% Voce precisa retornar a seguinte variavel corretamente
J = 0;

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule o custo de uma escolha particular de theta.
%             Voce precisa armazenar o valor do custo em J.

for i = 1 : m
   J = J + (((theta(1)*X(i,1) + theta(2)*X(i,2)) - (y(i)))^2);
end

J = J / (2*m);

% =========================================================================

end
