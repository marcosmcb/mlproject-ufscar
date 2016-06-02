function SVM_calculaResultados( targetData, nColAlvo )
% SVM_CALCULARESULTADOS ( targetData, nCOlAlvo)
% Calcula os resultados obtidos pelo SVM
%
% code by Rocchi™

%% Variaveis uteis

% valores da range usados no coarse grid search
cInicialLcoarse = -15;
cInicialGcoarse = -9;
gInicialGcoarse = -9;
passoCoarse = 2;

cInicialLnormal = -4;
cInicialGnormal = 0.5;
gInicialGnormal = -4;
passoNormal = 0.5;

%% Opcoes
	
fprintf('Opcoes: [1] - Coarse grid search [0] - Grid search normal\n');
opcao = input('> ');

if opcao == 1
	%% Calcula para Coarse Grid Search
	
	load('./SVM_results/acuraciaCoarse.mat');
	
	% KERNEL LINEAR
	fprintf('\nKernel Linear, resultados: \n');
	
	[nCs, ~] = size(accKernelLinear);
	
	maiorL = 1; % indice do maior elemento (indica o C dele)
	
	for i = 1:nCs
		
		compara = 0;
		
		for j = 1:nColAlvo
			
			if accKernelLinear(i,j) >= accKernelLinear(maiorL,j)
				compara = compara + 1;
			else
				compara = compara - 1;
			end
			
		end
		
		if compara > 0
			maiorL = i;
		end
		
	end
	
	fprintf('Melhor resultado: C = 2^%g\nAcuracias por coluna-alvo: \n', cInicialLcoarse + ( passoCoarse*(maiorL-1) ) );
	fprintf('%g ', accKernelLinear(maiorL,:));
	fprintf('\n');
	
	% KERNEL GAUSSIANO
	fprintf('\nKernel Gaussiano, resultados: \n');
	
	[nCs, nGammas, ~] = size(accKernelGaussiano);
	
	maiorG = [1 1]; % indices do maior elemento (entre C e gamma agora)
	
	for i = 1:nCs
		
		for j = 1:nGammas
		
			compara = 0;

			for k = 1:nColAlvo
				
				if accKernelGaussiano(i,j,k) >= accKernelGaussiano(maiorG(1), maiorG(2) ,k)
					compara = compara + 1;
				else
					compara = compara - 1;
				end

			end

			if compara > 0
				maiorG = [i j];
			end
		end
	end
	
	fprintf('Melhor resultado: C = 2^%g , gamma = 2^%g\nAcuracias por coluna-alvo: \n', ...
							cInicialGcoarse + ( passoCoarse*(maiorG(1)-1) ) , gInicialGcoarse + (passoCoarse*(maiorG(2)-1) ) );
	fprintf('%g ', accKernelGaussiano(maiorG(1), maiorG(2),:));
	fprintf('\n');
	
elseif opcao == 0
	%% Calcula para Normal Grid Search
	
	load('./SVM_results/acuraciaNormal.mat');
	
	% KERNEL LINEAR
	fprintf('\nKernel Linear, resultados: \n');
	
	[nCs, ~] = size(accKernelLinear);
	
	maiorL = 1; % indice do maior elemento (indica o C dele)
	
	for i = 1:nCs
		
		compara = 0;
		
		for j = 1:nColAlvo
			
			if accKernelLinear(i,j) >= accKernelLinear(maiorL,j)
				compara = compara + 1;
			else
				compara = compara - 1;
			end
			
		end
		
		if compara > 0
			maiorL = i;
		end
		
	end
	
	fprintf('Melhor resultado: C = 2^%g\nAcuracias por coluna-alvo: \n', cInicialLnormal + ( (maiorL-1) ) );
	fprintf('%g ', accKernelLinear(maiorL,:));
	fprintf('\n');
	
	% KERNEL GAUSSIANO
	fprintf('\nKernel Gaussiano, resultados: \n');
	
	[nCs, nGammas, ~] = size(accKernelGaussiano);
	
	maiorG = [1 1]; % indices do maior elemento (entre C e gamma agora)
	
	for i = 1:nCs
		
		for j = 1:nGammas
		
			compara = 0;

			for k = 1:nColAlvo
				
				if accKernelGaussiano(i,j,k) >= accKernelGaussiano(maiorG(1), maiorG(2) ,k)
					compara = compara + 1;
				else
					compara = compara - 1;
				end

			end

			if compara > 0
				maiorG = [i j];
			end
		end
	end
	
	fprintf('Melhor resultado: C = 2^%g , gamma = 2^%g\nAcuracias por coluna-alvo: \n', ...
							cInicialGnormal + ( passoNormal*(maiorG(1)-1) ) , gInicialGnormal + ((maiorG(2)-1) ) );
	fprintf('%g ', accKernelGaussiano(maiorG(1), maiorG(2),:));
	fprintf('\n');
end

end

