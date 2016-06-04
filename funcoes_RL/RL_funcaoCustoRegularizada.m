function [custo, gradiente] = RL_funcaoCustoRegularizada(thetas, trainData, targetData, lambda)
% Funcao que calcula o Custo e Gradiente da regressao Logistica
% Para o theta e lambda passados como parametro
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


%% Variaveis utilizadas

custo = 0; % inicializa / limpa o custo
gradiente = zeros(size(thetas)); % inicializa o gradiente

nElem = length(targetData); % numero de exemplos de treinamento
lambdaM = lambda/nElem; % (reducao de recalculo)

z = trainData * thetas;
hX = zeros(size(z)); % reducao de realocacoes
hX = 1 ./ (1 + exp(-z)); % funcao sigmoid (reducao de recalculo)

%% Funcao custo e calculo do gradiente

% Calculo do custo da regressao logistica com o theta e lambda fornecidos com regularizacao
custo = (-1/nElem) * sum( targetData .* log(hX) + (1-targetData) .* log(1 - hX) ) ... % custo, e
            + ( (lambda / (2*nElem)) * sum(thetas(2:end).^2)); % regularizacao

% Calculo do gradiente
gradiente = (trainData' * (hX - targetData)) ./ nElem + ( lambdaM * thetas);
gradiente(1) = gradiente(1) - ( lambdaM * thetas(1)); % remove a regularizacao do primeiro parametro

end
