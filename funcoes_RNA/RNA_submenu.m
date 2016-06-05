function RNA_submenu( trainData, testData, nColAlvo, opcaoMenu )
% RNA_submenu( trainData, testData, nColAlvo, opcaoMenu )
%
% Faz chamadas de funcoes das operacoes de Redes Neurais
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
[~, ~, ~] = mkdir('resultados_RNA');

%% Variaveis

%% Operacoes com os dados

%% Treinar
if opcaoMenu == 1

	tipoGridSearch = 0;
	
	while tipoGridSearch ~= 1 && tipoGridSearch ~= 2
		fprintf('Executar: \n[1] - Coarse Grid Search\n[2] - Normal Grid Search\n');
		tipoGridSearch = input('> ');
		
		if tipoGridSearch ~= 1 && tipoGridSearch ~= 2
			fprintf('Opcao invalida\n');
		end
	end
	
	RNA_treinar(trainData, nColAlvo, tipoGridSearch);

end

%% Avaliar
if opcaoMenu == 2
	
end

%% Testar
if opcaoMenu == 3
	
end



%%
%{


%% Variaveis necessarias

% cria a pasta para guardar os dados (se ja existir faz nada)
[~, ~, ~] = mkdir('resultados_RNA');

listaArquivos = dir('resultados_RNA');
[nArquivos, ~] = size(listaArquivos);

resp = 0; % recebe o input do usuario

numFold = 10; % numero de folds da cross validation

%% Inicializacao dos dados

[nLin, nCol] = size(trainData);

% separa as colunas alvo do resto da base de dados
trainData = trainData(:,1:nCol-nColAlvo);
targetData = trainData(:,nCol-nColAlvo+1:end);


%% Prepara os dados para o n-fold cross validation

nDataPfold = ceil(nLin/numFold);

trainDataFold = zeros(floor(nDataPfold*(numFold-1)), nCol-nColAlvo, numFold);
targetDataFold = zeros(floor(nDataPfold*(numFold-1)), nColAlvo, numFold);

testDataFold = zeros(floor(nDataPfold)-1, nCol-nColAlvo, numFold); % prealocacao
testTargetDataFold = zeros(floor(nDataPfold)-1, nColAlvo, numFold); % prealocacao

for i = 1:numFold

	[trainDataFoldPart, targetDataFoldPart, testDataFoldPart, testTargetDataFoldPart] = ...
				RNA_splitDadosNFold(trainData, targetData, numFold, i);
			
	trainDataFold(:,:,i) = trainDataFoldPart;
	targetDataFold(:,:,i) = targetDataFoldPart;
	
	testDataFold(:,:,i) = testDataFoldPart;
	testTargetDataFold(:,:,i) = testTargetDataFoldPart;

end

%% Menu de opcoes RNA

% Verificar se exitem arquivos salvos da RNA
	% Se sim, perguntar sobre gerar novamente, ou carregar e passar para testes
	% Se nao, da opcao de executar coarseGridSearch ou normalGridSearch

% Avaliacao dos resultados
	% Carrega os dados
	% Faz os calculos e mostra os resultados

%% Processamento dos dados

if nArquivos > 2 % '.' e '..' sempre contam
	fprintf('\nDados existentes do processamento da RNA encontrados\n');
	resp = input('[1] - Usar dados existentes\n[0] - Refazer processamento de dados\n> ');

	if ~resp
		
		fprintf('\nEntre com :\n');
		fprintf('[1] executar Coarse Grid Search (na RNA)\n');
		fprintf('[0] executar Grid Search normal (na RNA)\n');

		execCGS = input('> ');
		
		% apaga os arquivos antigos da pasta
		if execCGS == 1
			delete('./ANN_results/*_coarseGS.mat');
		end
		if execCGS == 0
			delete('./ANN_results/*_normalGS.mat');
		end
		
		% executa o n-fold cross validation
		tic
		for i = 1:numFold
			RNA_gridSearch(trainDataFold(:,:,i), targetDataFold(:,:,i), execCGS, nColAlvo, i);
			toc
		end

	else
		fprintf('Dados existentes serao utilizados...\n');
	end

else
	fprintf('\nDados da RNA nao encontrados\n');
	
	fprintf('Necessario refazer processamento de dados, opcoes: \n');
	fprintf('[1] executar Coarse Grid Search (na RNA)\n');
	fprintf('[0] executar Grid Search normal (na RNA)\n');

	execCGS = input('> ');

	% executa o n-fold cross validation
	tic
	for i = 1:numFold
		RNA_gridSearch(trainDataFold(:,:,i), targetDataFold(:,:,i), execCGS, nColAlvo, i);
		toc;
	end

end

%% Avaliacao dos resultados
%{
% Carregando dados

fprintf('\nAvaliar Coarse Grid Search ou Grid Search normal?\n');
resp = input('[1] - Coarse\n[0]- Normal\n> ');

if resp % Coarse
	fprintf('Carregando dados do Coarse Grid Search...\n');
	listArq = dir('ANN_results/*_coarseGS.mat');
else % Normal
	fprintf('Carregando dados do Grid Search normal...\n');
	listArq = dir('ANN_results/*_normalGS.mat');
end

[nArquivos, ~] = size(listArq);
fprintf('Arquivos encontrados: %g\n', nArquivos);

for i = 1:nArquivos
	% carrega variaveis
	
	%fprintf('\nCarregando arquivo: %s\n', listArq(i).name);
	nomeArquivo = strcat('./ANN_results/', listArq(i).name);
	load(nomeArquivo);
	% variaveis carregadas : nFold, RNA_pesos_InputInterm, RNA_pesos_IntermInterm, RNA_pesos_IntermOutput
	
	test = RNA_test(testDataFold(1, :, 1), RNA_pesos_InputInterm, RNA_pesos_IntermInterm, RNA_pesos_IntermOutput);
    test
	
	%fprintf('n-fold:%g, melhor lambda: %g\t', nFold, RL_lambdas(maior));
	%fprintf('Acuracias para esse lambda: ');
	%fprintf('%g\t', acuracia(maior,:));
	%fprintf('\n');
	
end
%}

%}
end
