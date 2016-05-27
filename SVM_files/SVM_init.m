function [ output_args ] = SVM_init( data )
%% Metodo de classificacao usando SVM
% essa funcao usa a libSVM, interface para treinamento com SVM
% disponivel em: http://www.csie.ntu.edu.tw/~cjlin/libsvm

% >> svmtrain
% mostra o help da funcao da libsvm

%% Inicializacao dos dados

nOut = 5; % numero de colunas alvo (ultimas do RL_data)
[SVM_dataLinhas, SVM_dataColunas] = size(data);

disp(SVM_dataLinhas); % RD (REMOVER DEPOIS)
disp(SVM_dataColunas); % RD

trainData = data(:,1:SVM_dataColunas-nOut);
targetData = data(:,SVM_dataColunas-nOut:end);

fprintf('Separou train e target\n'); % RD
disp(size(trainData)); % RD
disp(size(targetData)); % RD
fprintf('enter para continuar\n');
pause; % RD

%% gridSearch com kernel linear
fprintf('SVM - gridSearch com kernel linear\n');

melhorCoefVar = 0;
melhorC = 0;
melhorGamma = 0;

tic;
SVM_opcoes = ['-s 0 -t 2 -v 5 -c ', num2str(5), ' -g ', num2str(1), ' -h 0'];
coefVar = svmtrain(trainData, targetData, SVM_opcoes);
toc;

fprintf('RODOU!! coefVar: %g \n', coefVar); % RD

%{ 
/\ REMOVER DEPOIS
% sera que da pra usar um vetor de valores no iterador do for?
for SVM_C = -1:3 % C : parametro que multiplica o erro (MUDAR AQUI DEPOIS)
	for SVM_gamma = -4:1 % gamma
        
        % -s 0 : SVM tipo C-SVC
        % -t 0 : kernel tipo linear
        % -v 5 : n-fold cross validation (80-20)
        % -c X : multiplicador do erro (overfitting alert!!)
		% -g X : gamma, controla as bias e a variancia nos modelos (> > < | < < >)
		% -h 0 : heuristicas de shrinking (nao usar)
        
		SVM_opcoes = ['-s 0 -t 0 -v 5 -c ', num2str(SVM_C), ' -g 0', num2str(SVM_gamma), ' -h 0'];
		coefVar = svmtrain(trainData, targetData, SVM_opcoes);
		
		if coefVar >= melhorCoefVar
			melhorCoefVar = coefVar;
			melhorC = SVM_C;
			melhorGamma = SVM_gamma;
		end
		
		% %g : The more compact of %e or %f. Insignificant zeros do not print. -Documentacao do MatLab
		fprintf('roundAtual: taxa:%g C:%g gamma:%g | melhor: taxa:%g C:%g gamma:%g', ...
				coefVar, SVM_C, SVM_gamma, melhorCoefVar, melhorC, melhorGamma);
		
	end
end

%% SALVAR O MELHOR EM ARQUIVO

melhorCoefVarLinear = melhorCoefVar;
melhorCLinear = melhorC;
melhorGammaLinear = melhorGamma;

save('SVM_melhoresValores.mat', 'melhorCoefVarLinear', 'melhorCLinear', 'melhorGammaLinear');

%% gridSearch com kernel radial

melhorCoefVar = 0;
melhorC = 0;
melhorGamma = 0;

% sera que da pra usar um vetor de valores no iterador do for?
for SVM_C = -1:3 % C : parametro que multiplica o erro
	for SVM_gamma = -4:1 % gamma
        
        % -s 0 : SVM tipo C-SVC
        % -t 2 : kernel tipo radial
        % -v 5 : n-fold cross validation (80-20)
        % -c X : multiplicador do erro (overfitting alert!!)
		% -g X : gamma, controla as bias e a variancia nos modelos (> > < | < < >)
		% -h 0 : heuristicas de shrinking (nao usar)
        
		SVM_opcoes = ['-s 0 -t 2 -v 5 -c ', num2str(SVM_C), ' -g ', num2str(SVM_gamma), ' -h 0'];
		coefVar = svmtrain(trainData, targetData, SVM_opcoes);
		
		if coefVar >= melhorCoefVar
			melhorCoefVar = coefVar;
			melhorC = SVM_C;
			melhorGamma = SVM_gamma;
		end
		
		% %g : The more compact of %e or %f. Insignificant zeros do not print. -Documentacao do MatLab
		fprintf('roundAtual: taxa:%g C:%g gamma:%g | melhor: taxa:%g C:%g gamma:%g', ...
				coefVar, SVM_C, SVM_gamma, melhorCoefVar, melhorC, melhorGamma);
		
	end
end

%% SALVAR O MELHOR EM ARQUIVO

melhorCoefVarRadial = melhorCoefVar;
melhorCRadial = melhorC;
melhorGammaRadial = melhorGamma;

save('SVM_melhoresValores.mat', 'melhorCoefVarRadial', 'melhorCRadial', 'melhorGammaRadial', '-append');

%}
fprintf('\n');
end

