function [ output_args ] = KNN_classificar( trainData, nColAlvo, testData )
%KNN_CLASSIFICAR Summary of this function goes here
%   Detailed explanation goes here
	
	load( 'resultados_KNN/avaliacao_K_folds.mat'  );
	result = knn( trainData, K, nColAlvo, testData);
	dlmwrite('resultados_KNN/knn_teste_kaggle_result.csv', result, 'delimiter', ',');
	
end

