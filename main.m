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

%% Adding needed subfolders to path
addpath('./datasets_functions'); % funcoes de tratamento de dados
addpath('./RedesNeurais'); % funcao de redes neurais

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados do dataset [sem normalizacao] ...\n\n');
[ train_data, test_data ] = readData();

%% Displays the menu options and gets back the user's answer
menu(train_data, test_data);

%% Exiting
fprintf('\nFinalizando...\n');
%clear; close all; % removido para testes, decidir sobre mudar depois
