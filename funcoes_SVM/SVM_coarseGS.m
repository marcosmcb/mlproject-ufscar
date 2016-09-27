function SVM_coarseGS( trainData, targetData, nColAlvo )
% SVM_coarseGS 
% 
% Varia os parametros do SVM
% para uma porcentagem de dados da base escolhidos aleatoriamente
%
% code by Rocchi™

%% Variaveis uteis

[nAmostras, ~] = size(targetData);

%% Reducao do tamanho da base

p100elem = 0.1; % porcentagem dos elementos usadas no coarse grid search

toc;
fprintf('Iniciando Coarse gridSearch (na SVM)\n');

randomIndex = randperm(nAmostras); % permuta os indices randomicamente
nElemCoarse = floor(nAmostras * p100elem); % pega uma porcentagem das amostras para o coarse GS

% pega p100elem% randomicos dos dados
coarseTrainData = trainData(randomIndex(1:nElemCoarse),:);
coarseTargetData = targetData(randomIndex(1:nElemCoarse),:);

[nLinCoarse, ~] = size(coarseTrainData);

fprintf('Base reduzida para %g%% do total, numero de elementos: %g\n', p100elem*100, nLinCoarse);
toc;
fprintf('\n');

% dimensoes baseadas nas ranges de C e gamma
accKernelLinear = zeros(7, nColAlvo);
accKernelGaussiano = zeros(7, 7, nColAlvo);

%% Execucao do Coarse Grid Search para
%% Kernel LINEAR

tic;

fprintf('\nCoarse grid search para Kernel Linear\n');

iC = 0; % iterador para salvar resultados
	
% varia C (penalidade do parametro de erro)
for C = -15:2:-3 % valores baseados nas sugestoes dos criadores da libSVM

	iC = iC+1; % iterador para salvar resultados

	paramC = 2^C; % calcula o C real

	fprintf('SVM - CGS - parametros: Kernel Linear, C = %g\n', paramC);
	
	% -s 0 : SVM tipo C-SVC
	% -t 0 : kernel tipo linear(0)
	% -v 5 : n-fold cross validation (80-20)
	% -c X : multiplicador do erro (overfitting alert!!)
	% -h 0 : heuristicas de shrinking (0 = nao usar)
	% -q   : modo quieto, sem outputs

	SVM_opcoes = ['-s 0 -t 0 -v 5 -c ', num2str(paramC), ' -h 0 -q'];

	for i = 1:nColAlvo % uma para cada coluna alvo
		accKernelLinear(iC,i) = svmtrain(coarseTargetData(:,i), coarseTrainData, SVM_opcoes);
	end

	toc;

end % fim loop C

toc;


%% Kernel GAUSSIANO

tic; 

fprintf('\nCoarse grid search para Kernel Gaussiano\n');

iC = 0; % iterador para salvar resultados

% varia C (penalidade do parametro de erro)
for C = -9:2:3 % valores baseados nas sugestoes dos criadores da libSVM

	iC = iC+1; % iterador para salvar resultados
	iGamma = 0; % iterador para salvar resultados

	paramC = 2^C;

	% varia gamma (parametro livre do kernel gaussiano (multiplicador da norma))
	for gamma = -9:2:3 % valores baseados nas sugestoes dos criadores da libSVM

		iGamma = iGamma+1; % iterador para salvar resultados

		paramGamma = 2^gamma;

		fprintf('SVM - CGS - parametros: Kernel Gaussiano  C = %g  Gamma = %g\n', paramC, paramGamma);

		% -s 0 : SVM tipo C-SVC
		% -t 2 : kernel tipo Gaussiano(2)
		% -v 5 : n-fold cross validation (80-20)
		% -c X : multiplicador do erro (overfitting alert!!)
		% -g X : gamma, controla as bias e a variancia nos modelos (> > < | < < >)
		% -h 0 : heuristicas de shrinking (0 = nao usar)
		% -q   : modo quieto, sem outputs

		SVM_opcoes = ['-s 0 -t 2 -v 5 -c ', num2str(paramC), ' -g ', num2str(paramGamma), ' -h 0 -q'];

		for i = 1:nColAlvo % uma para cada coluna alvo
			accKernelGaussiano(iC, iGamma, i) = svmtrain(coarseTargetData(:,i), coarseTrainData, SVM_opcoes);
		end

		toc;

	end % fim loop gamma

	toc;

end % fim loop C

%% Salvando resultados em arquivo

fprintf('SVM - coarse grid search finalizada\nSalvando acuracias obtidas em arquivo...\n');
save('./SVM_results/acuraciaCoarse.mat', 'accKernelLinear', 'accKernelGaussiano')
toc;

end

