function RL_init( RL_data )
%% Essa funcao:
%{
    + Chama uma regressao logistica por saida alvo
    - Recebe diferentes datasets
    - Chama um gridSearch para cada dataset
%}

fprintf('Iniciando procedimentos para [REGRESSAO LOGISTICA]\n');

%% Iniciando parametros
nOut = 5; % numero de colunas alvo (ultimas do RL_data

[RL_dataLinhas, RL_dataColunas] = size(RL_data);

%test{
disp(RL_dataLinhas); % RD (REMOVER DEPOIS)
disp(RL_dataColunas); % RD

trainData = RL_data(:,1:RL_dataColunas-nOut);
targetData = RL_data(:,RL_dataColunas-nOut:end);

fprintf('Separou train e target\nenter para continuar\n'); % RD

disp(size(trainData)); % RD
disp(size(targetData)); % RD
pause; % RD

RL_lambda = 1; % passado para a funcao que otimiza o gradiente (VAI MUDAR NO GRIDSEARCH DEPOIS)
RL_principal(trainData, targetData, RL_lambda); % REMOVER QUANDO GRIDSEARCH ESTIVER PRONTO

%% FAZENDO O GRID SEARCH
%{
for I = 1:2 % variar o lambda
	for J = 1:2 % variar o Romero Brito
		for K = 1:2 % variar a variancia variavel de varios variados
			if 1 == 2
			 fprintf('Grid Search implementado!\n');
			end

			% Chamada da otimizacao
			%RL_principal(trainData, targetData, RL_lambda);

		end 
	end
end
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