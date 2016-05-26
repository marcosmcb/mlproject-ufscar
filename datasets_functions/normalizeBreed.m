function [ breed_arr1, breed_arr2 ] = normalizeBreed( breed_cells, animal_type_arr )

    [breed_col_A, breed_col_B ] = strtok(breed_cells, '/');
    
    breed_col_A = breed_col_A{1};
    breed_col_B = breed_col_B{1};
    
    sizeA = size(breed_col_A,1);
    sizeB = size(breed_col_B,1);

    for i=1:sizeA
        if( animal_type_arr(i) )
            breed_col_A(i) = breed2group( char( breed_col_A(i) ) );
        end
    end
    
    for i=1:sizeB
        if( animal_type_arr(i) )
            breed_col_B(i) = breed2group( char( breed_col_B(i) ) );
        end
    end

    breed_arr1 = dummyvar( grp2idx( breed_col_A ) );
    breed_arr2 = dummyvar( grp2idx( breed_col_B ) );

end