function [J, grad] = funcaoCustoReg(theta, X, y, lambda)
tic

m = length(y); % numero de exemplos de treinamento

J = 0;
e = exp(1);
grad = zeros(size(theta));

h_X = 1 ./ (1 + e .^ -(X * theta) );

J = (-1/m) * sum( y .* log(h_X) + (1-y) .* log(1 - h_X) ) + ( (lambda / (2*m)) * sum(theta(2:end).^2));

grad = (X' * (h_X - y)) ./ m + ( (lambda/m) * theta);
grad(1) = grad(1) - ( (lambda/m) * theta(1));

toc
end
