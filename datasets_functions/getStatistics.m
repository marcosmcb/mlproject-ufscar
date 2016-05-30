function getStatistics( dataset )

	[ ~, cols ] = size( dataset );
	print_to_file = input( 'Você deseja imprimir as estatisticas em um arquivo? [ 1-Sim 0-Nao]\n\n' );

	for i=1:cols
		displayColumnData( i , dataset , print_to_file);
	end;

end