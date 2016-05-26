function [RL_thetaOtimizado, RL_custoOtimizado] = RL_OtimizacaoGradiente( RL_entrada, RL_alvo , RL_lambda)
%% TO DO
% plotar o novo custo calculado a cada iteracao da fminunc

%% Chama a fminunc usando o lambda passado como parametro

fprintf('LR_gradientOptimization operations: using lambda = %d\n', RL_lambda);

% Inicializa os parametros que serao ajustados
RL_theta_inicial = zeros(size(RL_entrada, 2), 1);

% Configura opcoes
RL_opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

tic; % mede o tempo de execucao

% Otimiza o gradiente
[RL_thetaOtimizado, RL_custoOtimizado, exit_flag] = ...
        fminunc(@(t)(LR_costRegularized(t, RL_entrada, RL_alvo, RL_lambda)), RL_theta_inicial, RL_opcoes);

toc; % imprime o tempo de execucao

end

