function RL_avaliar()
% RL_avaliar()
%
% Carrega o arquivo adequado de resultados (e parametros), e
%
% Para o treino com grid search:
% - calcula as melhores acuracias e melhores parametros para cada coluna alvo
%
% Para o treino geral:
% - calcula a acuracia final de cada coluna
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%% Variaveis

opcaoAvaliacao = 0;


%% Escolha de opcao

fprintf('\nAvaliar: \n[1] - Coarse grid search\n[2] - Normal grid search\n[3] - Treino geral\n');
opcaoAvaliacao = input('> ');

%% Coarse grid search
if opcaoAvaliacao == 1
	% carrega os arquivos
	load('resultados_RL\coarse_parametros.mat', 'lambda');
	load('resultados_RL\coarse_resultados.mat');
	
	% chama funcao
	RL_melhorAcuraciaGridSearch(acuracias, lambda);
end


%% Normal grid search
if opcaoAvaliacao == 2
	% carrega os arquivos
	load('resultados_RL\normal_parametros.mat', 'lambda');
	load('resultados_RL\normal_resultados.mat');
	
	% chama funcao
	RL_melhorAcuraciaGridSearch(acuracias, lambda);
end


%% Treino geral
if opcaoAvaliacao == 3
	% carrega o arquivo
	load('resultados_RL\parametrosEresultadosTreinoGeral.mat');
	
	% chama funcao
	RL_melhorAcuraciaGeral(bla, bla, bla);
end


end

