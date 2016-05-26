function RL_init( trainData, test_data )
%% Essa funcao:
%{
    + Chama uma regressao logistica por saida alvo
    - Recebe diferentes datasets
    - Chama um gridSearch para cada dataset
%}

fprintf('Iniciando procedimentos para [REGRESSAO LOGISTICA]\n');

targetData = test_data;

%% FALTA FAZER O GRID SEARCH
for I = 1:2 % variar o lambda
    for J = 1:2 % variar o Romero Brito
        for K = 1:2 % variar a variancia variavel de varios variados
            if 1 == 2
             fprintf('Grid Search implementado!\n');
            end
            
        end
        
    end
    
end

%% Chamada da otimizacao
RL_lambda = 1; % passado para a funcao que otimiza o gradiente (VAI MUDAR NO GRIDSEARCH DEPOIS)

fprintf('RL - otimizando gradiente para lambda = %d\n', RL_lambda);
[RL_theta_y1, RL_custo_y1] = RL_OtimizacaoGradiente(trainData, targetData(1), RL_lambda);

fprintf('Salvando dados do theta otimizado encontrado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo = sprintf('RL_theta_y1_otimizado%d', RL_lambda);
save(RL_nomeArquivo, 'RL_custo_y1', 'RL_theta_y1');

[RL_theta_y2, RL_custo_y2] = RL_OtimizacaoGradiente(trainData, targetData(2), RL_lambda);

[RL_theta_y3, RL_custo_y3] = RL_OtimizacaoGradiente(trainData, targetData(3), RL_lambda);

[RL_theta_y4, RL_custo_y4] = RL_OtimizacaoGradiente(trainData, targetData(4), RL_lambda);

[RL_theta_y5, RL_custo_y5] = RL_OtimizacaoGradiente(trainData, targetData(5), RL_lambda);

%{
fprintf('Salvando dados do theta otimizado encontrado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo1 = sprintf('RL_theta_y_otimizado%d', RL_lambda);
save(RL_nomeArquivo1, 'RL_custo_y', 'RL_theta_y');
%}

%% Teste dos resultados (falta atualizar)
%{
fprintf('Teste dos resultados para a base de treino\n');
fprintf('carregando do arquivo de thetas calculados\n');
load('RL_theta_y1');
disp(size(RL_theta_y1));
% aplica os thetas
resultClassificado_y1 = RL_sigmoid(relevantVariables(1:2480,:) * RL_theta_y1);

%fprintf('resultado da classificacao para y1:\n');
%disp(resultClassificado_y1(1:5,1));
%disp(outcomeType(1:5,1));
disp(size(resultClassificado_y1));
disp(size(RL_theta_y1));

predizer = int8(resultClassificado_y1);
p = mod(predizer,2);

fprintf('calculando taxa de acerto com lambda igual a %d: \n', RL_lambda);
erroMedio = mean(double(p == outcomeType(1:2480,1))) * 100;
disp(erroMedio);
%}
end