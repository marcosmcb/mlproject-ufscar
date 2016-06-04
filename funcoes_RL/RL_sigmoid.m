function [ g ] = RL_sigmoid( z )
% [ g ] = RL_sigmoid( z )
%
% Calcula a funcao sigmoid de z, retorna em g
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

g = 1 ./ (1 + exp(-z));

end
