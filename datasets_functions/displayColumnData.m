function displayColumnData( column_idx, arr_data, print_to_file )

    [count, words, percentage] = getValuesFrequency( arr_data{ column_idx } );

    fprintf('Palavras\tNumero de Ocorrencias\tFrequencia \n\n');
    
    word_arr = words;
    freq_arr = num2cell( count' );
    perc_arr = num2cell( percentage' );

    [ ~, cols ] = size( percentage );
    if(cols > 10)
    	mat = [ word_arr(1:10, 1) freq_arr(1:10, 1) perc_arr(1:10, 1) ];
    else
    	mat = [ word_arr freq_arr perc_arr ];
    end;

    if( print_to_file )
    	printDatasetToFile( mat, './datasets_originals/dataset_statistics.txt' ,  '-append' );
    else
	    disp( mat );
    end;

    fprintf('Numero de Ocorrencias Unicas [ %d ] - Total de palavras [ %d ] \n\n', cols, sum(count) );

end