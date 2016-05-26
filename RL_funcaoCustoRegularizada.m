function [RL_custo, RL_grad] = RL_funcaoCustoRegularizada(theta, RL_entrada, RL_alvo, lambda)
%% Funcao que calcula o Custo e Gradiente da regressao Logistica
% Para o theta e lambda passados como parametro
%% Variaveis utilizadas

RL_custo = 0; % inicializa / limpa o custo
RL_grad = zeros(size(theta)); % inicializa o gradiente

RL_nElem = length(RL_alvo); % numero de exemplos de treinamento
% e = exp(1); % numero de euler (ou napier) (reducao de recalculo)
RL_lambdaM = lambda/RL_nElem; % (reducao de recalculo)

RL_z = RL_entrada * theta;
RL_hX = zeros(size(RL_z)); % reducao de realocacoes
RL_hX = 1 ./ (1 + exp(-RL_z)); % funcao sigmoid (reducao de recalculo)

%% Funcao custo e calculo do gradiente

% Calculo do custo da regressao logistica com o theta e lambda fornecidos com regularizacao
RL_custo = (-1/RL_nElem) * sum( RL_alvo .* log(RL_hX) + (1-RL_alvo) .* log(1 - RL_hX) ) ... % custo, e
            + ( (lambda / (2*RL_nElem)) * sum(theta(2:end).^2)); % regularizacao

% Calculo do gradiente
RL_grad = (RL_entrada' * (RL_hX - RL_alvo)) ./ RL_nElem + ( RL_lambdaM * theta);
RL_grad(1) = RL_grad(1) - ( RL_lambdaM * theta(1)); % remove a regularizacao do primeiro parametro

end
