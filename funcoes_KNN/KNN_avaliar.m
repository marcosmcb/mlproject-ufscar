function KNN_avaliar(  )
%KNN_AVALIARRESULTADOS Summary of this function goes here
%   Detailed explanation goes here
	
	load( 'resultados_KNN/avaliacao_K_folds.mat'  );

	% K varies from 1 to 12
	idx_Ks = zeros(12,1);
	best_results_K = zeros( 12, 2 );

	for idx=1:12

		idx_Ks = find( percentages_K_values( :, 1 )  == idx);
		best_results_K( idx, 1 ) = idx;
		best_results_K( idx, 2 ) = max( percentages_K_values( idx_Ks,2 ) );

	end;

	figure;
	min_x = min(best_results_K(:,1));
	max_x = max(best_results_K(:,1));

	plot( best_results_K(:,1), best_results_K(:,2), 'b--^', ...
		'LineWidth',3,...
    	'MarkerSize',10,...
    	'MarkerEdgeColor','b',...
    	'MarkerFaceColor',[1,0,0] );
	set(gca, 'xtick', [min_x : 1 : max_x] );
	grid on;
	title('Acuracia em funcao do numero de vizinhos - KNN');
	xlabel('Numero de vizinhos mais proximos (K)');
	ylabel('Acuracia (%)');


end

