function [ output_args ] = RL_principal( trainData, targetData , RL_lambda)

fprintf('RL - otimizando gradiente para lambda = %d\n', RL_lambda);


[RL_theta_y1, RL_custo_y1] = RL_OtimizacaoGradiente(trainData, targetData(1), RL_lambda);

fprintf('y1-Salvando dados do theta otimizado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo = sprintf('RL_theta_otmz_lambda%d', RL_lambda);
save(RL_nomeArquivo, 'RL_custo_y1', 'RL_theta_y1');

%{
/\ REMOVER DEPOIS
[RL_theta_y2, RL_custo_y2] = RL_OtimizacaoGradiente(trainData, targetData(2), RL_lambda);

fprintf('y2-Salvando dados do theta otimizado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo = sprintf('RL_theta_otmz_lambda%d', RL_lambda);
save(RL_nomeArquivo, 'RL_custo_y2', 'RL_theta_y2', '-append');

[RL_theta_y3, RL_custo_y3] = RL_OtimizacaoGradiente(trainData, targetData(3), RL_lambda);

fprintf('y3-Salvando dados do theta otimizado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo = sprintf('RL_theta_otmz_lambda%d', RL_lambda);
save(RL_nomeArquivo, 'RL_custo_y3', 'RL_theta_y3', '-append');

[RL_theta_y4, RL_custo_y4] = RL_OtimizacaoGradiente(trainData, targetData(4), RL_lambda);

fprintf('y4-Salvando dados do theta otimizado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo = sprintf('RL_theta_otmz_lambda%d', RL_lambda);
save(RL_nomeArquivo, 'RL_custo_y4', 'RL_theta_y4', '-append');

[RL_theta_y5, RL_custo_y5] = RL_OtimizacaoGradiente(trainData, targetData(5), RL_lambda);

fprintf('y5-Salvando dados do theta otimizado em arquivo (lambda = %d)\n', RL_lambda);
RL_nomeArquivo = sprintf('RL_theta_otmz_lambda%d', RL_lambda);
save(RL_nomeArquivo, 'RL_custo_y5', 'RL_theta_y5', '-append');
fprintf('\n');

%}

end
