function [RL_custo, RL_grad] = RL_funcaoCustoRegularizada(thetas, trainData, targetData, lambda)
%% Funcao que calcula o Custo e Gradiente da regressao Logistica
% Para o theta e lambda passados como parametro

%% Variaveis utilizadas

RL_custo = 0; % inicializa / limpa o custo
RL_grad = zeros(size(thetas)); % inicializa o gradiente

RL_nElem = length(targetData); % numero de exemplos de treinamento
% e = exp(1); % numero de euler (ou napier) (reducao de recalculo)
RL_lambdaM = lambda/RL_nElem; % (reducao de recalculo)

RL_z = trainData * thetas;
RL_hX = zeros(size(RL_z)); % reducao de realocacoes
RL_hX = 1 ./ (1 + exp(-RL_z)); % funcao sigmoid (reducao de recalculo)

%% Funcao custo e calculo do gradiente

% Calculo do custo da regressao logistica com o theta e lambda fornecidos com regularizacao
RL_custo = (-1/RL_nElem) * sum( targetData .* log(RL_hX) + (1-targetData) .* log(1 - RL_hX) ) ... % custo, e
            + ( (lambda / (2*RL_nElem)) * sum(thetas(2:end).^2)); % regularizacao

% Calculo do gradiente
RL_grad = (trainData' * (RL_hX - targetData)) ./ RL_nElem + ( RL_lambdaM * thetas);
RL_grad(1) = RL_grad(1) - ( RL_lambdaM * thetas(1)); % remove a regularizacao do primeiro parametro

end
