%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%  Projeto Final de Aprendizado de Máquina
%  Function: normalizeAndCleanerBreeds
%  Help:
%  Colunas de Resultado:
%  1 -          Names               (1 - se tem nome, 0 - c.c.);
%  2 -          Animal Type         (1 - Dog, 0 - Cat);
%  3 - 7 -      Sex Upon Out Come   (Vetor de Bits com 5 possibilidades);
%  8 -          Ages                (Valor em dias da idade);
%  9 - 65 -     Breed(main)         (Vetor de Bits com 57 possiblidades);
%  66 - 78 -    Breed(secondary)    (Vetor de Bits com 13 possiblidades);
%  79 - 135 -   Color(main)         (Vetor de Bits com 57 possiblidades);
%  136 - 179 -  Color(secondary)    (Vetor de Bits com 44 possiblidades);
%  180 - 184 -  Class(RESULT)       (Vetor de Bits com 5 possibilidades);
%

%% Initialization
clear all; close all; clc;

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados...\n\n');
[ train_data, test_data ] = readData();

%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

% Removes empty cells, noisy ones ('0 years') and transform the data
train_data = cleanDataSet( train_data, empty_arr, zeros_arr);


% =================== AgeUponOutCome cleaning ==================
	ages_arr = normalizeAgeuponOutcome( train_data{8} );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ====================== Names cleaning ========================
% 'With name' == 1 and 'without name' == 0
	names_arr = normalizeNames( train_data{2} );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% =================== AnimalType cleaning ======================
	% With 'dog' == 1 and 'cat' == 0
	animal_type_arr = normalizeAnimalType( train_data{6} );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ================= SexUponOutCome cleaning ====================
	sex_upon_out_come_arr = dummyvar( train_data(7) );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ======================= Breed cleaning =======================
	[train_data9a, train_data9b ] = strtok(train_data(9), '/');
    train_data9a = train_data9a{1};
    train_data9b = train_data9b{1};
    sizeT = size(train_data9a,1);
    breed_arr1_aux = train_data9a; %cell(size(train_data9a));
    breed_arr2_aux = cell(size(train_data9b));
    for i=1:sizeT
        if(animal_type_arr(i))
            breed_arr1_aux(i) = breed2group(char(train_data9a(i)));
        else
            breed_arr1_aux(i) = train_data9a(i);
        end
        %fprintf('%s\n', char(breed2group(char(train_data9a(i)))));
    end
    sizeT = size(train_data9b,1);
    for i=1:sizeT
        if(animal_type_arr(i))
            breed_arr2_aux(i) = breed2group(char(train_data9b(i)));
        else
            breed_arr2_aux(i) = train_data9b(i);
        end
    end
	breed_arr1 = dummyvar( grp2idx( breed_arr1_aux ) );
	breed_arr2 = dummyvar( grp2idx( breed_arr2_aux ) );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ====================== Color cleaning ========================
	[train_data10a, train_data10b ] = strtok(train_data(10), '/');
	color_arr1 = dummyvar( train_data10a );
	color_arr2 = dummyvar( train_data10b );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% ====================== Results cleaning ======================
	results = dummyvar( grp2idx( train_data{4} ) );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



%% Create a Final Clean and Top Matrix
MATRIX = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr1, breed_arr2, color_arr1, color_arr2, results];

MATRIX(isnan(MATRIX)) = 0;
fprintf('Imprindo os dados em um arquivo: "datasetNormalAndCleanWithGroupOfBreeds.csv "...\n\n');
dlmwrite('../datasets_normal&clean/datasetNormalAndCleanWithGroupOfBreeds.csv',MATRIX);

%% Exiting
clear; close all;