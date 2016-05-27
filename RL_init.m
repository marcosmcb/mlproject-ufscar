function RL_init( data, execCoarse, execGrid, nOutTest)
% RL_init (data, execCoarse, execGrid)
% Faz as operacoes iniciais da regressao logistica
%
% data : sao os dados brutos
% execCoarse : flag para ativar (>0) ou nao (0) a coarse gridsearch
% execGrid : flag para ativar (>0) ou nao (0) a gridsearch
% nOutTest : especifica quantas colunas ao final de 'data' sao colunas alvo [max=5]
%
% code by Rocchi™

%% Essa funcao:
%{
    + Chama uma regressao logistica por saida alvo
%}

fprintf('Iniciando procedimentos para [REGRESSAO LOGISTICA]\n');

%% Iniciando parametros

[RL_dataLinhas, RL_dataColunas] = size(data);
nOut = RL_dataColunas-nOutTest; % numero de colunas alvo (ultimas do RL_data)

disp(RL_dataLinhas); % RD (REMOVER DEPOIS)
disp(RL_dataColunas); % RD

trainData = data(:,1:nOut);
targetData = data(:,(nOut+1):end);

fprintf('Separou train e target data\n'); % RD
disp(size(trainData)); % RD
disp(size(targetData)); % RD
fprintf('pressione enter para continuar\n');
pause; % RD

% cria a pasta para guardar os dados
[~, ~, ~] = mkdir('RL_results');

%% Dados para o Coarse GridSearch

if execCoarse ~= 0
	fprintf('Iniciando Coarse gridSearc\n');

	randomIndex = randperm(RL_dataLinhas); % permuta os indices randomicamente
	dezPorCento = floor(RL_dataLinhas * 0.1); % pega 10% das amostras para o coarse GS

	% pega 10% randomicos dos dados
	coarseTrainData = trainData(randomIndex(1:dezPorCento),:);
	coarseTargetData = targetData(randomIndex(1:dezPorCento),:);

	% Coarse GridSearch
	tic;
	for coarseLambda = [0.01 0.05 0.1 0.25 0.5 1 2 5 10] % escolhidos empiricamente para buscar pelo melhor
		RL_principal(coarseTrainData, coarseTargetData, coarseLambda, nOutTest);
	end
	fprintf('Tempo de execucao da Coarse gridSearch: \n');
	toc;
	
	fprintf('Fim da Coarse gridSearch, enter para continuar\n'); % RparcialmenteD
	pause; % RD
	
else
	fprinft('Pulando coarse gridSearch\n');
end

%% set de variaveis - MUDAR/REMOVER DEPOIS

RL_lambda = 1; % passado para a funcao que otimiza o gradiente (VAI MUDAR NO GRIDSEARCH DEPOIS)
% RL_principal(trainData, targetData, RL_lambda, nOutTest); % REMOVER QUANDO GRIDSEARCH ESTIVER PRONTO

%% FAZENDO O GRID SEARCH

if execGrid == 0 % OU NAO
	fprintf('Pulando o gridSearch\n');
	return; % termina a funcao caso execGrid seja 0
	% MUDAR DEPOIS, se for fazer a parte de teste dos resultados aqui
end

%{
for I = 1:2 % variar o lambda
	for J = 1:2 % variar o Romero Brito
		for K = 1:2 % variar a variancia variavel de varios variados
			if 1 == 2
			 fprintf('Grid Search implementado!\n');
			end

			% Chamada da otimizacao
			%RL_principal(trainData, targetData, RL_lambda, nOutTest);

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