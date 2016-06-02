function SVM_normalGS( trainData, targetData, nColAlvo )
% SVM_NORMALGS Summary of this function goes here
% 
% Faz uma busca mais detalhada nos dados usando parametros refinados
%
% code by Rocchi™

% Melhores resultados da Coarse grid search:
% Linear - C=2^-3
% Gaussiana - C=2^1 gamma=2^-3

% nao usar -q e salvar command window em arquivo usando...
% diary('./SVM_results/normalGS_saida.txt');
% diary on; pra iniciar
% diary off; quando acabar

% Gravar saidas do terminal em arquivo para recolher os dados necessarios depois: 
diary('./SVM_results/normalGS_saida_Linear.txt');

%% Reducao do tamanho da base

fprintf('Iniciando Coarse gridSearch (na SVM)\n');

% dimensoes baseadas nas ranges de C e gamma
accKernelLinear = zeros(9, nColAlvo);
accKernelGaussiano = zeros(5, 9, nColAlvo);

%% Execucao do Coarse Grid Search para
%% Kernel LINEAR

tic;

fprintf('\nGrid search normal para Kernel Linear\n');

iC = 0; % iterador para salvar resultados
	
% varia C (penalidade do parametro de erro)
for C = [-4 -3 -2] % valores baseados nas sugestoes dos criadores da libSVM
	
	diary on;

	iC = iC+1; % iterador para salvar resultados

	paramC = 2^C; % calcula o C real

	fprintf('SVM - NGS - parametros: Kernel Linear, C = %g\n', paramC);
	
	% -s 0 : SVM tipo C-SVC
	% -t 0 : kernel tipo linear(0)
	% -v 5 : n-fold cross validation (80-20)
	% -c X : multiplicador do erro (overfitting alert!!)
	% -h 0 : heuristicas de shrinking (0 = nao usar)

	SVM_opcoes = ['-s 0 -t 0 -v 5 -c ', num2str(paramC), ' -h 0'];

	for i = 1:nColAlvo % uma para cada coluna alvo
		accKernelLinear(iC,i) = svmtrain(targetData(:,i), trainData, SVM_opcoes);
	end

	toc;
		
	diary off;


end % fim loop C

toc;

%% Kernel GAUSSIANO
diary('./SVM_results/normalGS_saida_Gaussiano.txt');

tic; 

fprintf('\nGrid search normal para Kernel Gaussiano\n');

iC = 0; % iterador para salvar resultados

% varia C (penalidade do parametro de erro)
for C = [0.5 1 1.5]  % valores baseados nas sugestoes dos criadores da libSVM
	
	diary on;

	iC = iC+1; % iterador para salvar resultados
	iGamma = 0; % iterador para salvar resultados

	paramC = 2^C;

	% varia gamma (parametro livre do kernel gaussiano (multiplicador da norma))
	for gamma = [-4 -3 -2] % valores baseados em buscas usando a coarse grid search

		iGamma = iGamma+1; % iterador para salvar resultados

		paramGamma = 2^gamma;

		fprintf('SVM - NGS - parametros: Kernel Gaussiano  C = %g  Gamma = %g\n', paramC, paramGamma);

		% -s 0 : SVM tipo C-SVC
		% -t 2 : kernel tipo Gaussiano(2)
		% -v 5 : n-fold cross validation (80-20)
		% -c X : multiplicador do erro (overfitting alert!!)
		% -g X : gamma, controla as bias e a variancia nos modelos (> > < | < < >)
		% -h 0 : heuristicas de shrinking (0 = nao usar)

		SVM_opcoes = ['-s 0 -t 2 -v 5 -c ', num2str(paramC), ' -g ', num2str(paramGamma), ' -h 0'];

		for i = 1:nColAlvo % uma para cada coluna alvo
			accKernelGaussiano(iC, iGamma, i) = svmtrain(targetData(:,i), trainData, SVM_opcoes);
		end

		toc;

	end % fim loop gamma

	toc;
	diary off;

end % fim loop C

%% Salvando resultados em arquivo

fprintf('SVM - coarse grid search finalizada\nSalvando acuracias obtidas em arquivo...\n');
save('./SVM_results/acuraciaNormal.mat', 'accKernelLinear', 'accKernelGaussiano')
toc;

end
