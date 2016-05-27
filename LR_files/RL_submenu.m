function RL_submenu( train_dataset_normalized, nColAlvo )
% RL_submenu( train_dataset_normalized )
% Recebe uma base de dados e mostra opcoes de execucao
% das operacoes da regressao logistica
%
% code by Rocchi™

%% Inicializacao da base de dados (separacao e inclusao de atributos polinomiais)

% fprintf('Adicionando atributos polinomiais a base de treino.\n');

[~,nCol] = size(train_dataset_normalized);

% separa as colunas alvo do resto da base de dados
trainData = train_dataset_normalized(:,1:nCol-nColAlvo);
targetData = train_dataset_normalized(:,nCol-nColAlvo+1:end);

%test
%{
disp(size(trainData));
disp(size(targetData));
pause;
%}

trainData = [trainData, RL_atributosPolinomiais(trainData, 8)];

%% Variaveis necessarias

% cria a pasta para guardar os dados (se ja existir faz nada)
[~, ~, ~] = mkdir('RL_results');

listaArquivos = dir('RL_results');
[nArquivos, ~] = size(listaArquivos);

resp = 0; % recebe o input do usuario

[nLinhasData, nColData] = size(trainData); % dimensoes dos dados de entrada

%% Menu de opcoes da regresao Logistica

% Verificar se exitem arquivos salvos da regressao logistica
	% Se sim, perguntar sobre gerar novamente, ou carregar e passar para testes
	% Se nao, da opcao de executar coarseGridSearch ou normalGridSearch

% Avaliacao dos resultados
	% Carrega os dados
	% Faz os calculos e mostra os resultados

%% Processamento dos dados

if nArquivos > 2 % '.' e '..' sempre contam
	fprintf('\nDados existentes do processamento da Regressao Logistica encontrados\n');
	resp = input('[1] - Usar dados existentes\n[0] - Refazer processamento de dados\n> ');

	if ~resp
		
		fprintf('\nEntre com :\n');
		fprintf('[1] executar Coarse Grid Search (na Regressao Logistica)\n');
		fprintf('[0] executar Grid Search normal (na Regressao Logistica)\n');

		execCGS = input('> ');
		
		% apaga os arquivos antigos da pasta
		delete('./RL_results/*_coarse.mat', './RL_results/*_normal.mat');
		
		% por enquanto só usa o train_dataset_normalized, depois o n-fold cross validation muda isso
		% ultimo parametro sao as colunas alvo
		RL_gridSearch(trainData, targetData, execCGS, nColAlvo);

	else
		fprintf('Dados existentes serao utilizados...\n');
	end

else
	fprintf('\nDados da Regressao Logistica nao encontrados\n');
	
	fprintf('Necessario refazer processamento de dados, opcoes: \n');
	fprintf('[1] executar Coarse Grid Search (na Regressao Logistica)\n');
	fprintf('[0] executar Grid Search normal (na Regressao Logistica)\n');

	execCGS = input('> ');

	% por enquanto só usa o train_dataset_normalized, depois o n-fold cross validation muda isso
	RL_gridSearch(trainData, targetData, execCGS, 5);

end

%% Avalicao dos resultados

% Carregando dados

fprintf('\nAvaliar Coarse Grid Search ou Grid Search normal?\n');
resp = input('[1] - Coarse\n[0]- Normal\n> ');

if resp % Coarse
	fprintf('Carregando dados do Coarse Grid Search...\n');
	listArq = dir('RL_results/*_coarse.mat');

	[nArquivos, ~] = size(listArq);

	fprintf('Numero de arquivos encontrados: %g\n', nArquivos);

else % Normal
	fprintf('Carregando dados do Grid Search normal...\n');
	listArq = dir('RL_results/*_normal.mat');

	[nArquivos, ~] = size(listArq);

	fprintf('Arquivos encontrados: %g\n', nArquivos);

end

% Calculando resultados
if resp
	fprintf('Acuracia da base para a coarse grid search: \n');
else
	fprintf('Acuracia da base para a grid search normal: \n');
end

max = zeros(nColAlvo,1);
melhorLambda = 0;

for i = 1:nArquivos
	
	% carrega variaveis
	nomeArquivo = strcat('./RL_results/', listArq(i).name);
	% fprintf('Carregando arquivo: %s\n', listArq(i).name);
	load(nomeArquivo);
	
	% chama funcao que calcula acuracia (e salva os resultados)
	acuracia = RL_calculaResultados(trainData, targetData, RL_thetaMatrix, nColAlvo);
	
	% mostra resultados
	fprintf('lambda = %g\t (por coluna-alvo) acuracia = ', RL_lambda);
	fprintf('%g\t', acuracia);
	fprintf('\n');
	
	% verifica o melhor
	compara = 0;
	for j = 1:nColAlvo
		if(acuracia(j) > max(j))
			compara = compara + 1;
		else
			compara = compara - 1;
		end
	end
	
	if compara > 0
		max = acuracia;
		melhorLambda = RL_lambda;
	end
end

fprintf('\nMelhor lambda: %g\n', melhorLambda);
fprintf('Acuracias para esse lambda: ');
fprintf('%g\t', acuracia);
fprintf('\n');

end
