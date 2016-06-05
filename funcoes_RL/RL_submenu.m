function RL_submenu( trainData, testData, nColAlvo, opcaoMenu )
% RL_submenu( trainData, testData, nColAlvo, opcaoMenu )
%
% Faz chamadas de funcoes das operacoes da regressao logistica
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372



%{
Estrutura do submenu

	Faz operacoes com os dados se necessario

	if opcao == TREINAR

	if opcao == AVALIAR

	if opcao == CLASSIFICAR

%}

% cria a pasta para guardar os dados (se ja existir faz nada)
[~, ~, ~] = mkdir('resultados_RL');


%% Treinar
if opcaoMenu == 1
	
	opcaoTreino = 0;
	
	while opcaoTreino < 1 || opcaoTreino > 3
		fprintf('\nExecutar: \n[1] - Coarse Grid Search\n[2] - Normal Grid Search\n[3] - Treino com a base inteira\n');
		opcaoTreino = input('> ');
		
		if opcaoTreino < 1 || opcaoTreino > 3
			fprintf('Opcao invalida\n');
		end
	end
	
	% faz adição de atributos polinomiais, n-fold cross validation, coarse gridSearch ou normal gridSearch
	RL_treinar(trainData, nColAlvo, opcaoTreino);
	
end

%% Avaliar
if opcaoMenu == 2
	RL_avaliar();
end

%% Classificar
if opcaoMenu == 3
	RL_classificar(testData, nColAlvo);
end


%% Codigo antigo
%{


%% Variaveis necessarias

% cria a pasta para guardar os dados (se ja existir faz nada)
[~, ~, ~] = mkdir('resultados_RL');

listaArquivos = dir('resultados_RL');
[nArquivos, ~] = size(listaArquivos);

resp = 0; % recebe o input do usuario

numFold = 10; % numero de folds da cross validation

%% Inicializacao dos dados

[~,nCol] = size(trainData);

% separa as colunas alvo do resto da base de dados
trainData = trainData(:,1:nCol-nColAlvo);
targetData = trainData(:,nCol-nColAlvo+1:end);


%% Atributos polinomiais

fprintf('Adicionando atributos polinomiais a base de treino...\n');
tic
trainData = RL_atributosPolinomiais(trainData, 8);
toc
[nLin, nCol] = size(trainData);
fprintf('Atributos polinomiais adicionados, tamanho dos dados: %g %g\n', nLin, nCol);


%% Prepara os dados para o n-fold cross validation

nDataPfold = ceil(nLin/numFold);

trainDataFold = zeros(floor(nDataPfold*(numFold-1)), nCol, numFold);
targetDataFold = zeros(floor(nDataPfold*(numFold-1)), nColAlvo, numFold);

testDataFold = zeros(floor(nDataPfold)-1, nCol, numFold); % prealocacao
testTargetDataFold = zeros(floor(nDataPfold)-1, nColAlvo, numFold); % prealocacao

for i = 1:numFold

	[trainDataFoldPart, targetDataFoldPart, testDataFoldPart, testTargetDataFoldPart] = ...
				RL_splitDadosNFold(trainData, targetData, numFold, i);
			
	trainDataFold(:,:,i) = trainDataFoldPart;
	targetDataFold(:,:,i) = targetDataFoldPart;
	
	testDataFold(:,:,i) = testDataFoldPart;
	testTargetDataFold(:,:,i) = testTargetDataFoldPart;

end

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
		if execCGS == 1
			delete('./RL_results/*_coarseGS.mat');
		end
		if execCGS == 0
			delete('./RL_results/*_normalGS.mat');
		end
		
		% executa o n-fold cross validation
		tic
		for i = 1:numFold
			RL_gridSearch(trainDataFold(:,:,i), targetDataFold(:,:,i), execCGS, nColAlvo, i);
			toc
		end

	else
		fprintf('Dados existentes serao utilizados...\n');
	end

else
	fprintf('\nDados da Regressao Logistica nao encontrados\n');
	
	fprintf('Necessario refazer processamento de dados, opcoes: \n');
	fprintf('[1] executar Coarse Grid Search (na Regressao Logistica)\n');
	fprintf('[0] executar Grid Search normal (na Regressao Logistica)\n');

	execCGS = input('> ');

	% executa o n-fold cross validation
	tic
	for i = 1:numFold
		RL_gridSearch(trainDataFold(:,:,i), targetDataFold(:,:,i), execCGS, nColAlvo, i);
		toc;
	end

end

%% Avaliacao dos resultados (ATUALIZANDO)

% Carregando dados

fprintf('\nAvaliar Coarse Grid Search ou Grid Search normal?\n');
resp = input('[1] - Coarse\n[0]- Normal\n> ');

if resp % Coarse
	fprintf('Carregando dados do Coarse Grid Search...\n');
	listArq = dir('RL_results/*_coarseGS.mat');
else % Normal
	fprintf('Carregando dados do Grid Search normal...\n');
	listArq = dir('RL_results/*_normalGS.mat');
end

[nArquivos, ~] = size(listArq);
fprintf('Arquivos encontrados: %g\n', nArquivos);

for i = 1:nArquivos
	% carrega variaveis
	
	%fprintf('\nCarregando arquivo: %s\n', listArq(i).name);
	nomeArquivo = strcat('./RL_results/', listArq(i).name);
	load(nomeArquivo);
	
	% variaveis carregadas : nFold, RL_custosVector, RL_lambdas, RL_thetasMatrix
	[~, nLambdas] = size(RL_lambdas);
	
	acuracia = zeros(nLambdas, nColAlvo);
	maior = 1;
	
	for j = 1:nLambdas 
		acuracia(j,:) = RL_calculaResultados(testDataFold(:,:,i), testTargetDataFold(:,:,i), RL_thetasMatrix(:,:,j), nColAlvo);
		
		compara = 0;
		for k = 1:nColAlvo
			if acuracia(j,k) >= acuracia(maior,k)
				compara = compara + 1;
			else
				compara = compara - 1;
			end
		end
		
		if compara > 0
			%fprintf('NOVO MAIOR j=%g > maior=%g por %g\n', j, maior, compara);
			maior = j;
		%else
			%fprintf('i=%g < max=%g, compara=%g\n', i, maior, compara);
		end
		
	end
	
	fprintf('n-fold:%g, melhor lambda: %g\t', nFold, RL_lambdas(maior));
	fprintf('Acuracias para esse lambda: ');
	fprintf('%g\t', acuracia(maior,:));
	fprintf('\n');
	
end
%}
end
