function [ output_args ] = SVM_init( trainData, targetData )
%% Metodo de classificacao usando SVM
% essa funcao usa a libSVM, interface para treinamento com SVM
% disponivel em: http://www.csie.ntu.edu.tw/~cjlin/libsvm

% >> svmtrain
% mostra o help da funcao da libsvm

%% gridSearch com kernel linear

melhorCoefVar = 0;
melhorC = 0;
melhorGamma = 0;

% sera que da pra usar um vetor de valores no iterador do for?
for SVM_C = -1:3 % C : parametro que multiplica o erro (MUDAR AQUI DEPOIS)
	for SVM_gamma = -4:1 % gamma
        
        % -s 0 : SVM tipo C-SVC
        % -t 0 : kernel tipo linear
        % -v 5 : n-fold cross validation (80-20)
        % -c X : multiplicador do erro (overfitting alert!!)
		% -g X : gamma, controla as bias e a variancia nos modelos (> > < | < < >)
        
		SVM_opcoes = ['-s 0 -t 0 -v 5 -c ', num2str(SVM_C), ' -g ', num2str(SVM_gamma)];
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
        
		SVM_opcoes = ['-s 0 -t 2 -v 5 -c ', num2str(SVM_C), ' -g ', num2str(SVM_gamma)];
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

end

