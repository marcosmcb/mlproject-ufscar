function [] = criar_rna()
%function [ custos ] = criar_rna(training_data, training_target_data, num_camadas_interm, num_neurs_interm)

    %output: matriz de custos
    % custos[l][n][c] // l = layer/camada, n = neuronios da camada, c = custos  
    % daquele neuronio pra cada neuronio da próxima camada;
    % // (matriz vai ficar transposta  em relação à rede mas é mais fácil pra 
    % pensar no código)
    
    clear all; close all; clc;
    
    %% dummy data
    
    training_data = rand(27000, 6);
    training_target_data = rand(27000, 5);
    num_camadas_interm = 1; % forward propagation funciona só pra 1 por enquanto
    num_neurs_interm = 18;
    
    tam_camada(1:num_camadas_interm + 2) = num_neurs_interm;
    tam_camada(1) = size(training_data, 2);
    tam_camada(num_camadas_interm + 2) = size(training_target_data, 2);

    %% cria matriz de custos
    % custos de cada neurônio da camada (incluindo +1 de bias) para cada neurônio da próxima camada
    
    custos_primeira = zeros(tam_camada(1) + 1, tam_camada(2));
    custos_interm = zeros(num_camadas_interm - 2 + 1, num_neurs_interm + 1, num_neurs_interm);
    custos_penult = zeros(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada)));
    
    % primeira camada
    range = sqrt(6) / sqrt(tam_camada(1) + tam_camada(2));
    custos_primeira = (range + range) .* rand(tam_camada(1) + 1, tam_camada(2)) - range;
    
    % camadas intermediárias até penúltima
    for i = 2 : num_camadas_interm - 1

        range = sqrt(6) / sqrt(tam_camada(i) + tam_camada(i + 1));
        custos_camada = (range + range) .* rand(tam_camada(i) + 1, tam_camada(i + 1)) - range;
        
        for j = 1 : size(custos_camada, 1)
            for k = 1 : size(custos_camada, 2)
                custos_interm(i, j, k) = custos_camada(j, k);
            end
        end
    end
    
    % penultima camada
    range = sqrt(6) / sqrt(tam_camada(length(tam_camada) - 1) + tam_camada(length(tam_camada)));
    custos_penult = (range + range) .* rand(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada))) - range;


    %% learning
    e = exp(1);
    
    for row_n = 1:size(training_data, 1)
        %% forward propagation
        
        a_primeira = [1;training_data(row_n, :)']'; % concatena valor 1 do bias com dados de entrada
        
        a_interm = zeros(num_neurs_interm, 1)'; %por enquanto pra 1 camada
        %a_interm = zeros(num_camadas_interm, num_neurs_interm);
        
        a_ultima = zeros(tam_camada(length(tam_camada)), 1)';
        
        % concatena 1 (bias) com os resultados das sigmoids do resultado dos
        % neuronios[1 x 7neurs] * custos[7neurs x 8 neurs] = [1 x 8neurs]
        a_interm = [1;(1 ./ (1 + e .^ -(a_primeira * custos_primeira)))']';
        
        % resultados das sigmoids do resultado dos 
        % neuronios[1 x 9neurs] * custos[9neurs x 5 saidas] = [1 x 5saidas]
        a_ultima = (1 ./ (1 + e .^ -(a_interm * custos_penult)));
        
        
        %% backpropagation
        
        
    end
end

