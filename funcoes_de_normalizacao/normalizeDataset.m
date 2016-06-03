function [train_dataset_normalized, test_dataset_normalized, nColAlvo] = normalizeDataset( train_data, test_data )
% [train_dataset_normalized, test_dataset_normalized] = normalizeDataset( train_data, test_data )
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
[nElemeTeste, ~] = size(testId);


%% Juntar os dados de treino e teste para normalizacao de fato

temNome = [trainNome; testNome];
resultado = trainResultado; % nao presente na base de teste
tipoAnimal = [trainTipoAnimal; testTipoAnimal];
sexo = [trainSexo; testSexo];
idade = [trainIdade; testIdade];
raca = [trainRaca; testRaca];
cor = [trainCor; testCor];

fprintf('Inicializacao dos dados feita\n'); toc;

%% Nome

% vetor binario se um animal possui ou nao nome
temNomeBin = zeros(temNome,1);
temNomeBin(~cellfun(@isempty, temNome)) = 1;

fprintf('Coluna Nome normalizada\n'); toc;

%% Tipo

% vetor binario se um animal e cao(1) ou gato(0)
tipoAnimalBin = zeros(size(tipoAnimal));
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


pause;


%% Codigo antigo
%{

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

% Removes empty cells, noisy ones ('0 years') and transform the data
train_data = cleanDataSet( train_data, empty_arr, zeros_arr);


%% Start to actually normalize the dataset, the previous steps were performed to clean the dataset


[ages_arrNN] = normalizeAgeuponOutcome( train_data{8} );
% normalize age range
[ages_arr, MU, SIGMA] = zscore(ages_arrNN);


% 'With name' == 1 and 'without name' == 0
names_arr = normalizeNames( train_data{2} );

% With dog == 1 and cat == 0
animal_type_arr = normalizeAnimalType( train_data{6} );

%SexUponOutCome cleaning
[sex_upon_out_come_arr, sex_uniques_arr] =  normalizeSexUponOutcome( train_data(7) ) ;
sex_upon_out_come_arr = binarizeColumn( sex_upon_out_come_arr );


%Breed cleaning
[breed_arr_A, breed_arr_B, breedA_preDummy, breedB_preDummy] = normalizeBreed( train_data(9) , animal_type_arr);

%Color cleaning
[color_arr, pattern_arr] = splitColorAndPattern( train_data(10) );

%Classes normalization
%The columns are in this disposal:
%Return_to_owner | Euthanasia | Adoption | Transfer | Died
results = dummyvar( grp2idx( train_data{4} ) );

%% Final steps

% Create a Normalized and Clean Matrix (with breeds and colour normalization)
train_dataset_normalized = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr_A, breed_arr_B, color_arr, pattern_arr, results];


% ======================= No Breed cleaning =======================
	[ auxA, auxB ] = strtok(train_data(9), '/');
	no_breed_cleaning_A = dummyvar( auxA );
	no_breed_cleaning_B = dummyvar( auxB );
% =================================================================

train_dataset_colour = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, no_breed_cleaning_A, no_breed_cleaning_B, color_arr, pattern_arr, results];

% ====================== Color cleaning ========================
	[ auxA, auxB ] = strtok(train_data(10), '/');
	no_colour_cleaningA = dummyvar( auxA );
	no_colour_cleaningB = dummyvar( auxB );
% =================================================================

train_dataset_breed = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr_A, breed_arr_B, no_colour_cleaningA, no_colour_cleaningB, results];

train_dataset_no_colour_breed = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, no_breed_cleaning_A, no_breed_cleaning_B, no_colour_cleaningA, no_colour_cleaningB, results];

train_dataset_normalized = eliminateNaN( train_dataset_normalized );
train_dataset_colour = eliminateNaN( train_dataset_colour );
train_dataset_breed = eliminateNaN( train_dataset_breed );
train_dataset_no_colour_breed = eliminateNaN( train_dataset_no_colour_breed );


%% Processing test_data

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( test_data{6} );

% Removes empty cells, noisy ones ('0 years') and transform the data
test_data = cleanDataSet( test_data, empty_arr, zeros_arr);


% Start to actually normalize the dataset, the previous steps were performed to clean the dataset

% to normalize the age column we need to adjust the cells not in train age range
biggestAge = max(ages_arrNN);
smallestAge = min(ages_arrNN);

ages_arr = normalizeAgeuponOutcomeTest( test_data{6}, biggestAge, smallestAge );

% normalize age range
ages_arr = zscore(ages_arr);

% 'With name' == 1 and 'without name' == 0
names_arr = normalizeNames( test_data{2} );

% With dog == 1 and cat == 0
animal_type_arr = normalizeAnimalType( test_data{4} );

%SexUponOutCome cleaning
sex_upon_out_come_arr = binarizeColumnTest( test_data(5) , train_data(7), sex_upon_out_come_arr);

%Breed cleaning
[~, sizeBreedA] = size(breed_arr_A);
[~, sizeBreedB] = size(breed_arr_B);
[breed_arr_A, breed_arr_B] = normalizeBreedTest( test_data(7) , animal_type_arr, breedA_preDummy, breedB_preDummy, sizeBreedA, sizeBreedB);

%Color cleaning
[color_arr, pattern_arr] = splitColorAndPattern( test_data(8) );


			% Final steps

% Create a Normalized and Clean Matrix (with breeds and colour normalization)
test_dataset_normalized = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr_A, breed_arr_B, color_arr, pattern_arr];

test_dataset_normalized = eliminateNaN( test_dataset_normalized );
toc;

%% Saving processesd datasets

fprintf('Salvando datasets processados em arquivo...\n');

breedA_preDummy = unique(breedA_preDummy);
breedB_preDummy = unique(breedB_preDummy);

save( 'mapping_data.mat', 'MU', 'SIGMA', 'sex_uniques_arr', 'breedA_preDummy', 'breedB_preDummy' );

% salva os dados na pasta raiz mesmo
save('normalized_data.mat', 'train_dataset_normalized', 'train_dataset_colour', ... 
	'train_dataset_breed', 'train_dataset_no_colour_breed', 'test_dataset_normalized');

fprintf('Datasets salvos!\n');
%}

end