function [RL_thetaOtimizado, RL_custoOtimizado] = RL_OtimizacaoGradiente( dados_entrada, dados_alvo , RL_lambda)
% [RL_thetaOtimizado, RL_custoOtimizado] = RL_OtimizacaoGradiente( dados_entrada, dados_alvo , RL_lambda)
% Funcao que chama a fminunc com a funcao de custo regularizada da regressao logistica
% 
% dados_entrada : dados usado para o treinamento
% dados_alvo :  dados-alvo usados para o treinamento
% RL_lambda : valor de lambda usado na funcao
%
% code by Rocchi™

%% TO DO
% plotar o novo custo calculado a cada iteracao da fminunc

%% Chama a fminunc usando o lambda passado como parametro

% Inicializa os parametros que serao ajustados
RL_theta_inicial = zeros(size(dados_entrada, 2), 1);

% Configura opcoes
RL_opcoes = optimset('GradObj', 'on', 'MaxIter', 400, 'Display', 'off');

% tic % mede o tempo de execucao (tem um anterior)

% Otimiza o gradiente
[RL_thetaOtimizado, RL_custoOtimizado, ~, ~] = ...
        fminunc(@(t)(RL_funcaoCustoRegularizada(t, dados_entrada, dados_alvo, RL_lambda)), ...
																RL_theta_inicial, RL_opcoes);

toc % imprime o tempo de execucao

end

