function [J, grad] = funcaoCustoReg(theta, X, y, lambda)
%FUNCAOCUSTOREG Calcula o custo da regressao logistica com regularizacao
%   J = FUNCAOCUSTOREG(theta, X, y, lambda) calcula o custo de usar theta 
%   como parametros da regressao logistica para ajustar os dados de X e y 

% Inicializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento

% Voce precisa retornar as seguintes variaveis corretamente
J = 0;
grad = zeros(size(theta));

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Calcule o custo de uma escolha particular de theta.
%             Voce precisa armazenar o valor do custo em J.
%             Calcule as derivadas parciais e encontre o valor do gradiente
%             para o custo com relacao ao parametro theta
%
% Obs: grad deve ter a mesma dimensao de theta
%

h_X = sigmoid(X * theta);

J = (-1/m) * sum( y .* log(h_X) + (1-y) .* log(1 - h_X) ) + ( (lambda / (2*m)) * sum(theta(2:end).^2));

grad = (X' * (h_X - y)) ./ m + ( (lambda/m) * theta);
grad(1) = grad(1) - ( (lambda/m) * theta(1));

% =============================================================

end
