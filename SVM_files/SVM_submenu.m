function SVM_submenu( train_dataset , nColAlvo )
% SVM_SUBMENU( train_dataset )
% 
% Sub menu para oferecer as opcoes de execucao da SVM
% nos dados passados como argumento, opcoes disponiveis:
%
% treinar com os dados
% avaliar dados
% 

%% Estrutura do submenu
%{
	faz separacao dos dados para n-fold cross validation

	treinar com os dados (com n-fold cross validation)
		- coarseGridSearch - salva dados apos executar
		- normalGridSearch - salva dados apos executar

	avaliar dados
		carrega dados salvos em arquivos
		aplica predicao neles
		mostra os resultados	

%}

%% Cria pasta para guardar os resultados

[~, ~, ~] = mkdir('SVM_results');

%% Separacao inicial dos dados

[~,nCol] = size(train_dataset);

% separa as colunas alvo do resto da base de dados
trainData = train_dataset(:,1:nCol-nColAlvo);
targetData = train_dataset(:,nCol-nColAlvo+1:end);


%% Entrada do usuario

fprintf('SVM_submenu - Entre com uma das opcoes: \n');
fprintf('[1] - Treinar classificador\n');
fprintf('[0] - Avaliar resultados\n');
opcao = input('> ');

if opcao == 1
	%% Treinar com os dados
	fprintf('\nTreinar com...\n');
	fprintf('[1] - Coarse Grid Search\n');
	fprintf('[0] - Normal Grid Search\n');
	opcao = input('> ');
	
	if opcao == 1
		%% Coarse Grid Search
		fprintf('Executando Coarse Grid Search\n');

		SVM_coarseGS(trainData, targetData, nColAlvo);
	
	elseif opcao == 0
		%% Normal Grid Search
		fprintf('Executando Grid Search normal\n');
		
		% coarse grid search
		SVM_normalGS(trainData, targetData, nColAlvo);
		
	end
	
	fprintf('Deseja avaliar resultados? [1] - Sim [0] - Nao\n');
	opcao = ~input('> ');
	
end

if opcao == 0
	%% Avaliar resultados
	fprintf('Avaliando resultados\n');
	
	SVM_calculaResultados(targetData, nColAlvo);
	
end

end
