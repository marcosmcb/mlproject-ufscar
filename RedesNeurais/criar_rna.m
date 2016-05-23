function [] = criar_rna()
%function [ pesos ] = criar_rna(training_data, training_target_data, num_camadas_interm, num_neurs_interm, taxa_aprendizagem)

    %output: matriz de pesos
    % pesos[l][n][c] // l = layer/camada, n = neuronios da camada à esquerda, 
    % c = pesos daquele neuronio pra cada neuronio da camada à direita;
    % // (matriz vai ficar transposta  em relação à rede mas é mais fácil pra 
    % pensar no código)
    
    clear all; close all; clc;
    
    %% dummy data
    
    training_data = rand(27000, 6);
    training_target_data = rand(27000, 5);
    num_camadas_interm = 1; % forward propagation e backpropagation funcionam só pra 1 por enquanto
    num_neurs_interm = 8;
    gamma = 1; % taxa de aprendizagem
    
    tam_camada(1:num_camadas_interm + 2) = num_neurs_interm;
    tam_camada(1) = size(training_data, 2);
    tam_camada(num_camadas_interm + 2) = size(training_target_data, 2);

    %% cria matriz de pesos
    % pesos de cada neurônio da camada à esquerda (incluindo +1 de bias)
    % para cada neurônio da camada à esquerda
    
    pesos_InputInterm = zeros(tam_camada(1) + 1, tam_camada(2));
    pesos_interm_interm = zeros(num_camadas_interm - 2 + 1, num_neurs_interm + 1, num_neurs_interm);
    pesos_IntermOutput = zeros(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada)));
    
    % input -> interm
    range = sqrt(6) / sqrt(tam_camada(1) + tam_camada(2));
    pesos_InputInterm = (range + range) .* rand(tam_camada(1) + 1, tam_camada(2)) - range;
    
    % interm -> interm
    for i = 2 : num_camadas_interm - 1

        range = sqrt(6) / sqrt(tam_camada(i) + tam_camada(i + 1));
        pesos_camada = (range + range) .* rand(tam_camada(i) + 1, tam_camada(i + 1)) - range;
        
        for j = 1 : size(pesos_camada, 1)
            for k = 1 : size(pesos_camada, 2)
                pesos_interm_interm(i, j, k) = pesos_camada(j, k);
            end
        end
    end
    
    % interm -> output
    range = sqrt(6) / sqrt(tam_camada(length(tam_camada) - 1) + tam_camada(length(tam_camada)));
    pesos_IntermOutput = (range + range) .* rand(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada))) - range;


    %% learning
    
    delta_InputInterm = zeros(tam_camada(1) + 1, tam_camada(2));
    delta_IntermOutput = zeros(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada)));
    
    for row_n = 1:size(training_data, 1)
        %% forward propagation
        
        input = horzcat(1, training_data(row_n, :)); % concatena valor 1 do bias com dados de entrada
        
        % bias + resultados das sigmoids do resultado dos inputs[1 x 7 (6+bias)] * pesos[7inputs x 8 neurs] = [1 x 8ativs]
        a_interm = horzcat(1, 1 ./ (1 + exp(-input * pesos_InputInterm)));
        derivs_a_interm = a_interm .* (1 - a_interm);
        
        % resultados das sigmoids do resultado dos neuronios[1 x 9neurs (8+bias)] * pesos[9neurs x 5 saidas] = [1 x 5saidas]
        a_output = 1 ./ (1 + exp(-a_interm * pesos_IntermOutput));
        derivs_a_output = a_output .* (1 - a_output);
        
        
        %% backpropagation
        
        erros_l_output = a_output - training_target_data(row_n, :);
        %erros_r_output = ((a_output - training_target_data(row_n, :)) .^ 2) ./ 2;
        %erro_total = erro_total + sum(erros_r_output); % iniciar com 0 antes
        
        erros_backprop_output = derivs_a_output .* erros_l_output;
        derivs_IntermOutput = a_interm' * erros_backprop_output;
        
        erros_backprop_interm = derivs_a_interm .* (pesos_IntermOutput * erros_backprop_output')';
        derivs_InputInterm = input' * erros_backprop_interm(2:size(erros_backprop_interm, 2)); % ignora primeiro erro pois input não é ligado com bias da prox camada
        
        %% online training (atualiza pesos a cada linha entrada)
        
        %pesos_InputInterm = pesos_InputInterm - (derivs_InputInterm * gamma);
        %pesos_IntermOutput = pesos_IntermOutput - (derivs_IntermOutput * gamma);
        
        %% offline training accumulation
        
        delta_InputInterm = delta_InputInterm - (derivs_InputInterm * gamma);
        delta_IntermOutput = delta_IntermOutput - (derivs_IntermOutput * gamma);
        
    end
    
    %% offline training (atualiza pesos baseado na soma dos deltas de todas as entradas)
    pesos_InputInterm = pesos_InputInterm - delta_InputInterm;
    pesos_IntermOutput = pesos_IntermOutput - delta_IntermOutput;
end

