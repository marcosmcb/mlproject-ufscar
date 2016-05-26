%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Projeto Aprendizado de MÃ¡quina - Shelter Animal Outcomes ( www.kaggle.com )
%
%
%

%% Esquema possivel da Main - Rocchi
%{
	limpa as coisas
	addpath do que for necessario
	// definicao: ASK = oferecer opcao pro usuario opcoes e receber resposta dele
	primeiro ASK : fornecer info estatistica dos dados (originais) (que ja esta implementado)
	segundo ASK : opcao de (re)fazer a normalizacao dos dados
		se sim refaz e salva em arquivo
		se nao carrega dos arquivos salvos
		// pode usar uma variavel pra dizer se existem dados salvos ou nao (mesmo esquema de ED2)
		// FUNCAO exist() do matlab faz isto (diferentes retornos inteiros, checa na doc do mathworks os retornos)

	terceiro ASK : rodar treinamento dos classificadores OU rodar teste com parametros salvos em arquivo
		aqui que ou demora meses pra rodar os treinamentos (com submenus pra caso queira rodar so um ou outro)
		ou roda os testes com os parametros e mostra os resultados, graficos e et cætera

	quarto ASK : plotar o que puder? ou plota no 3º ASK já...
		// usar PCA? --> possivel
%}

%% Initialization
clear all; close all; clc;

addpath('./datasets_functions'); % funcoes de tratamento de dados
addpath('./RedesNeurais'); % funcao de redes neurais

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados...\n\n');
[ train_data, test_data ] = readData();

% Displays the menu options and gets back the user's answer
menu_resp = menu();

% Option to bypass this menu selection if a value not in 1-9 range is selected
if (menu_resp >= 1) && (menu_resp <= 10)
    displayColumnData( menu_resp, train_data );
end;


%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');
tic;
[ train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed ] = normalizeDataset( train_data );
toc;

%% Call to Logistic Regression using the training data
%{
fprintf('pressione enter para chamar a regressao logistica com train_dataset_normalized\n');
pause;
RL_init(train_dataset_normalized);
%}

%{
fprintf('pressione enter para chamar a regressao logistica com train_dataset_no_colour_breed\n');
pause;
RL_init(train_dataset_no_colour_breed);
%}

%% Call to Support Vector Machine using the training data
% {
fprintf('pressione enter para chamar a svm\n');
pause;
SVM_init(train_dataset_normalized);
%}

%% Exiting
fprintf('\nExiting...\n');
%clear; close all; % removido para testes, decidir sobre mudar depois
