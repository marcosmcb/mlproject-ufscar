function chamaLogistica( X, y )
%% chamada inicial com theta inicial (zeros)
% deixei so pra testar, tirar depois e deixar so a fminunc
theta_inicial = zeros(size(X, 2), 1);

lambda = 1; % mudar no gridSearch

[custo, grad] = funcaoCustoReg(theta_inicial, X, y, lambda);

fprintf('\n\nCusto para theta inicial (zeros): %f\n', custo);

fprintf('\nProximo passo eh o fminunc (demorado, aperte enter com responsabilidade)\n');
pause;

%% Chama a fminunc usando a funcaoCustoReg

% Inicializa os parametros que serao ajustados
theta_inicial = zeros(size(X, 2), 1);

% Configura o parametro regularizacao lambda igual a 1
lambda = 1;

% Configura opticoes
opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

% Otimiza o gradiente
[theta, J, exit_flag] = ...
	fminunc(@(t)(funcaoCustoReg(t, X, y, lambda)), theta_inicial, opcoes);

fprintf('\nCusto para theta otimo encontrado por fminunc: %f\n', J);

fprintf('\nFIM DA FMINUNC\n\n');
pause;

end

