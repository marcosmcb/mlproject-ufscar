function KNN_submenu( trainData, testData, nColAlvo, opcaoMenu )
% KNN_submenu( trainData, testData, nColAlvo, opcaoMenu )
%
% Faz chamadas de funcoes das operacoes do KNN
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

	%{
	Estrutura do submenu

		Faz operacoes com os dados se necessario

		if opcao == TREINAR

		if opcao == AVALIAR

		if opcao == CLASSIFICAR

	%}

	%% Variaveis

	%% Operacoes com os dados

	%% Treinar
	if opcaoMenu == 1
		[K, perc] = KNN_treinar(trainData, nColAlvo);
		fprintf( '\n\n\nValor do melhor K = %d , Valor da Taxa de Acerto = [%f]\n\n\n' , K, perc);
	end

	%% Avaliar
	if opcaoMenu == 2
		fprintf('\n\n\nPlotagem dos valores de K de acordo com a sua melhor acurácia\n\n\n');
		KNN_avaliar( );
	end

	%% Testar
	if opcaoMenu == 3
		KNN_classificar(testData, nColAlvo, testData);
	end

end
