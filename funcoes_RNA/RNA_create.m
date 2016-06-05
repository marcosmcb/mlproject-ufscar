function [ pesos_InputInterm, pesos_IntermInterm, pesos_IntermOutput ] = ...
    RNA_create(training_data, training_target_data, num_neurs_interm, num_epocas)
    %            tx_aprend, num_epocas)

    %% dummy data
    %{
    training_data = (2.5 - 1) .* rand(27000, 1) + 1;
    training_target_data = log(training_data);%rand(27000, 5);
    num_neurs_interm = 8;
    tx_aprend = 1; % taxa de aprendizagem
    num_epocas = 300;
    %}

    %% cria matriz de pesos
    
    num_camadas_interm = 1; % forward propagation e backpropagation funcionam só pra 1 por enquanto

    tam_camada(1:num_camadas_interm + 2) = num_neurs_interm;
    tam_camada(1) = size(training_data, 2);
    tam_camada(num_camadas_interm + 2) = size(training_target_data, 2);

    % pesos de cada neurônio da camada à esquerda (incluindo +1 de bias)
    % para cada neurônio da camada à esquerda
    
    pesos_InputInterm = zeros(tam_camada(1) + 1, tam_camada(2));
    pesos_IntermInterm = zeros(num_camadas_interm - 2 + 1, num_neurs_interm + 1, num_neurs_interm);
    pesos_IntermOutput = zeros(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada)));
    
    txAprend_InputInterm = ones(tam_camada(1) + 1, tam_camada(2)) * 0.1;
    txAprend_IntermInterm = ones(num_camadas_interm - 2 + 1, num_neurs_interm + 1, num_neurs_interm) * 0.1;
    txAprend_IntermOutput = ones(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada))) * 0.1;

    % input -> interm
    range = sqrt(6) / sqrt(tam_camada(1) + tam_camada(2));
    pesos_InputInterm = (range + range) .* rand(tam_camada(1) + 1, tam_camada(2)) - range;
    
    % interm -> interm
    for i = 2 : num_camadas_interm - 1

        range = sqrt(6) / sqrt(tam_camada(i) + tam_camada(i + 1));
        pesos_camada = (range + range) .* rand(tam_camada(i) + 1, tam_camada(i + 1)) - range;
        
        for j = 1 : size(pesos_camada, 1)
            for k = 1 : size(pesos_camada, 2)
                pesos_IntermInterm(i, j, k) = pesos_camada(j, k);
            end
        end
    end
    
    % interm -> output
    range = sqrt(6) / sqrt(tam_camada(length(tam_camada) - 1) + tam_camada(length(tam_camada)));
    pesos_IntermOutput = (range + range) .* rand(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada))) - range;


    %% learning
    derivAcum_InputInterm_prev = zeros(tam_camada(1) + 1, tam_camada(2));
    derivAcum_IntermOutput_prev = zeros(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada)));

    for epoch = 1:num_epocas
    %tic
        % acumulação de deltas pro offline training
        derivAcum_InputInterm = zeros(tam_camada(1) + 1, tam_camada(2));
        derivAcum_IntermOutput = zeros(tam_camada(length(tam_camada) - 1) + 1, tam_camada(length(tam_camada)));
        
        % aleatorização dos dados pra cada época do online training
        %randomized_rows = randperm(size(training_data, 1));
        %training_data = training_data(randomized_rows, :);
        %training_target_data = training_target_data(randomized_rows, :);

        for row_n = 1:size(training_data, 1)
            %% forward propagation

            a_input = horzcat(1, training_data(row_n, :)); % concatena valor 1 do bias com dados de entrada

            % bias + resultados das sigmoids do resultado dos inputs[1 x 7 (6+bias)] * pesos[7inputs x 8 neurs] = [1 x 8ativs]
            a_interm = horzcat(1, 1 ./ (1 + exp(-a_input * pesos_InputInterm)));
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
            derivs_InputInterm = a_input' * erros_backprop_interm(2:size(erros_backprop_interm, 2)); % ignora primeiro erro pois input não é ligado com bias da prox camada

            %% online training (atualiza pesos a cada linha entrada)
            
            %pesos_InputInterm = pesos_InputInterm - (derivs_InputInterm * tx_aprend);
            %pesos_IntermOutput = pesos_IntermOutput - (derivs_IntermOutput * tx_aprend);

            %% offline/batch training accumulation

            derivAcum_InputInterm = derivAcum_InputInterm + derivs_InputInterm;
            derivAcum_IntermOutput = derivAcum_IntermOutput + derivs_IntermOutput;

        end
        
        %% offline/batch training com Rprop (atualiza pesos baseado na soma dos deltas de todas as entradas)
        signInputInterm = derivAcum_InputInterm .* derivAcum_InputInterm_prev;
        for idx = 1:numel(signInputInterm)
            if signInputInterm(idx) > 0
                txAprend_InputInterm(idx) = min(txAprend_InputInterm(idx) * 1.2, 50);
                delta = -sign(derivAcum_InputInterm(idx)) * txAprend_InputInterm(idx);
                pesos_InputInterm(idx) = pesos_InputInterm(idx) + delta;
                derivAcum_InputInterm_prev(idx) = derivAcum_InputInterm(idx);
            
            elseif signInputInterm(idx) < 0
                txAprend_InputInterm(idx) = max(txAprend_InputInterm(idx) * 0.5, 0.000001);
                derivAcum_InputInterm_prev(idx) = 0;
                
            else
                delta = -sign(derivAcum_InputInterm(idx)) * txAprend_InputInterm(idx);
                pesos_InputInterm(idx) = pesos_InputInterm(idx) + delta;
                derivAcum_InputInterm_prev(idx) = derivAcum_InputInterm(idx);
            end
        end
        
        signIntermOutput = derivAcum_IntermOutput .* derivAcum_IntermOutput_prev;
        for idx = 1:numel(signIntermOutput)
            if signIntermOutput(idx) > 0
                txAprend_IntermOutput(idx) = min(txAprend_IntermOutput(idx) * 1.2, 50);
                delta = -sign(derivAcum_IntermOutput(idx)) * txAprend_IntermOutput(idx);
                pesos_IntermOutput(idx) = pesos_IntermOutput(idx) + delta;
                derivAcum_IntermOutput_prev(idx) = derivAcum_IntermOutput(idx);
            
            elseif signIntermOutput(idx) < 0
                txAprend_IntermOutput(idx) = max(txAprend_IntermOutput(idx) * 0.5, 0.000001);
                derivAcum_IntermOutput_prev(idx) = 0;
                
            else
                delta = -sign(derivAcum_IntermOutput(idx)) * txAprend_IntermOutput(idx);
                pesos_IntermOutput(idx) = pesos_IntermOutput(idx) + delta;
                derivAcum_IntermOutput_prev(idx) = derivAcum_IntermOutput(idx);
            end
        end

        %pesos_InputInterm = pesos_InputInterm + (derivAcum_InputInterm * tx_aprend);
        %pesos_IntermOutput = pesos_IntermOutput + (derivAcum_IntermOutput * tx_aprend);
    %toc
    end

    %{
    entrada = 0;
    while entrada <= 2.5
        entrada = input('Valor: ')
    
        a_input = horzcat(1, entrada);
        a_interm = horzcat(1, 1 ./ (1 + exp(-a_input * pesos_InputInterm)));
        a_output = 1 ./ (1 + exp(-a_interm * pesos_IntermOutput));

        fprintf('Saida: ');
        a_output
        fprintf('Log(entrada): ')
        log(entrada)
    end
    %}
end

