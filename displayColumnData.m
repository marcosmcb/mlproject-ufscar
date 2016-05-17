function displayColumnData( column_idx, arr_data )

    [count, words, percentage] = getValuesFrequency( arr_data{ column_idx } );
    fprintf('Palavras \t Número de Ocorrências \t Frequência');
    [words num2cell(count') num2cell(percentage')]
    fprintf('Número de Ocorrências - Somatório [ %d ] palavras \n\n', sum( count ) );

end