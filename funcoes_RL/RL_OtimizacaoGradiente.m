function [thetaOtimizado, custoOtimizado] = RL_OtimizacaoGradiente( trainData, targetData , lambda)
% [thetaOtimizado, custoOtimizado] = RL_OtimizacaoGradiente( trainData, targetData, lambda)
% Funcao que chama a fminunc com a funcao de custo regularizada da regressao logistica
% 
% trainData : dados usado para o treinamento
% targetData :  dados-alvo usados para o treinamento
% lambda : valor de lambda usado na funcao
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis

% Inicia o parametro que sera otimizado
theta_inicial = zeros(size(trainData, 2), 1);
% Configura opcoes da fminunc
opcoes = optimset('GradObj', 'on', 'MaxIter', 400, 'Display', 'off');

%% Chama a fminunc usando o lambda passado como parametro

% Otimiza o gradiente
[thetaOtimizado, custoOtimizado, ~, ~] = fminunc(@(t) ...
	(RL_funcaoCustoRegularizada(t, trainData, targetData, lambda)), theta_inicial, opcoes);


end
