function [trainDatasetNormalized, testDatasetNormalized, nColAlvo] = normalizeDataset( train_data, test_data )
% [trainDatasetNormalized, testDatasetNormalized, nColAlvo] = normalizeDataset( train_data, test_data )
%
% Faz a normalizacao dos dados de treino e teste
%
% UFSCar BCC 2016-1 - Aprendizado de Maquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%{
	Esquema da normalizacao:

	- Transforma as celulas de dados orignais em vetores de celulas por coluna
	- Junta as colunas relevantes de treino e teste em uma unica variavel por coluna
	- Normaliza:
		- Nome
		- Tipo
		- Resultado - coluna alvo
		- Sexo
		- Idade
		- Raca
		- Cor
%}

tic;
%% Transformar de celulas por colunas para vetores de celulas

% para os dados de treino
trainId = train_data{1}; % irrelevante
trainNome = train_data{2}; % verificar se possui ou nao apenas
%trainData = train_data{3}; % irrelevante
trainResultado = train_data{4}; % COLUNA-ALVO
%trainSubresultado = train_data{5}; % irrelevante
trainTipoAnimal = train_data{6}; % transformar em binario (1-cao 2-gato)
trainSexo = train_data{7}; % aplicar dummyvar
trainIdade = train_data{8}; % aplicar conversao para inteiros (reusar codigo)
trainRaca = train_data{9}; % aplicar processamento de separacao (reusar codigo)
trainCor = train_data{10}; % aplicar processamento de separacao (reusar codigo)

% para os dados de teste
testId = test_data{1}; % guardar para imprimir saida formato Kaggle(? - nao necessario se nao remover ou permutar linhas)
testNome = test_data{2}; % verificar se possui ou nao apenas
%testData = test_data{3}; % irrelevante
testTipoAnimal = test_data{4}; % transformar em binario (1-cao 2-gato)
testSexo = test_data{5}; % aplicar dummyvar
testIdade = test_data{6}; % aplicar conversao para inteiros (reusar codigo)
testRaca = test_data{7}; % aplicar processamento de separacao (reusar codigo)
testCor = test_data{8}; % aplicar processamento de separacao (reusar codigo)

% Numero de elementos em cada base
[nElemTreino, ~] = size(trainId);
[nElemTeste, ~] = size(testId);


%% Juntar os dados de treino e teste para normalizacao de fato

temNome = [trainNome; testNome];
resultado = trainResultado; % nao presente na base de teste
tipoAnimal = [trainTipoAnimal; testTipoAnimal];
sexo = [trainSexo; testSexo];
idade = [trainIdade; testIdade];
raca = [trainRaca; testRaca];
cor = [trainCor; testCor];

[nElem, ~] = size(temNome);

fprintf('Inicializacao dos dados feita\n'); toc;

%% Nome

% vetor binario se um animal possui(1) ou nao(0) nome
temNomeBin = zeros(nElem,1);
temNomeBin(~cellfun(@isempty, temNome)) = 1;

fprintf('Coluna Nome normalizada\n'); toc;

%% Tipo

% vetor binario se um animal e cao(1) ou gato(0)
tipoAnimalBin = zeros(nElem, 1);
tipoAnimalBin(strcmp(tipoAnimal, 'Dog')) = 1;

fprintf('Coluna Tipo normalizada\n'); toc;

%% Resultado - Coluna Alvo

% matriz binaria representando a coluna-alvo
resultadoBin = dummyvar(grp2idx(resultado));

% o resultado anterior resulta na seguinte correspondencia de colunas (ordem de aparicao):
% Return_to_owner | Euthanasia | Adoption | Transfer | Died

% aqui nos corrigimos para o modelo de saida:
% Adoption | Died | Euthanasia | Return_to_owner | Transfer
resultadoBin = [resultadoBin(:,3), resultadoBin(:,5), resultadoBin(:,2), resultadoBin(:,1), resultadoBin(:,4)];

% variavel que guarda o numero de colunas binarias que representam a coluna-alvo
[~, nColAlvo] = size(resultadoBin);

fprintf('Coluna Resultado normalizada\n'); toc;

%% Sexo

% troca as colunas sem valor para Unknown
sexo{strcmp(sexo, '')} = 'Unknown';

% aplica dummyvar
sexoBin = dummyvar(grp2idx(sexo));

fprintf('Coluna Sexo normalizada\n'); toc;

%% Idade

% funcao que faz a conversao de texto para inteiros e normaliza por padronizacao
idadeNorm = normalizeAgeuponOutcome(idade);

fprintf('Coluna Idade normalizada\n'); toc;

%% Raca

% funcao que 
racaBin = normalizeBreed(raca, tipoAnimalBin);

fprintf('Coluna Raca normalizada\n'); toc;

%% Cor
corBin = splitColorAndPattern(cor);

fprintf('Coluna Cor normalizada\n'); toc;


%% Separar treino e teste, juntar resultados ao treino

trainDatasetNormalized = [temNomeBin(1:nElemTreino,:), tipoAnimalBin(1:nElemTreino,:), sexoBin(1:nElemTreino,:), ...
							idadeNorm(1:nElemTreino, :), racaBin(1:nElemTreino,:), corBin(1:nElemTreino,:), resultadoBin];

% poderia usar (nElem-nElemTeste)+1 tambem nos indices
testDatasetNormalized = [temNomeBin(nElemTreino+1:end,:), tipoAnimalBin(nElemTreino+1:end,:), sexoBin(nElemTreino+1:end,:), ...
							idadeNorm(nElemTreino+1:end, :), racaBin(nElemTreino+1:end,:), corBin(nElemTreino+1:end,:)];


%% Salvar em arquivo os resultados

nomeArquivo = 'normalized_data.mat';
save(nomeArquivo, 'trainDatasetNormalized', 'testDatasetNormalized', 'nColAlvo');

fprintf('Dados salvos em arquivo (%s)\n', nomeArquivo); toc;

end