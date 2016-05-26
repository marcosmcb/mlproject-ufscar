function [ train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed ] = normalizeDataset( train_data )
    
    % Gets the empty and noisy cells from the column AgesuponOutcome
    [zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

    % Removes empty cells, noisy ones ('0 years') and transform the data
    train_data = cleanDataSet( train_data, empty_arr, zeros_arr);
    
    %% Start to actually normalize the dataset, the previous steps were performed to clean the dataset
    ages_arr = normalizeAgeuponOutcome( train_data{8} );

    % 'With name' == 1 and 'without name' == 0
    names_arr = normalizeNames( train_data{2} );

    % With dog == 1 and cat == 0
    animal_type_arr = normalizeAnimalType( train_data{6} );

    %SexUponOutCome cleaning
    sex_upon_out_come_arr = binarizeColumn( train_data(7) );

    %Breed cleaning
    [breed_arr_A, breed_arr_B] = normalizeBreed( train_data(9) , animal_type_arr);
    
    %Color cleaning
    [color_arr, pattern_arr] = splitColorAndPattern( train_data(10) );

    %Classes normalization
    results = dummyvar( grp2idx( train_data{4} ) );


    % Create a Normalized and Clean Matrix (with breeds and colour normalization)
    train_dataset_normalized = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr_A, breed_arr_B, color_arr, pattern_arr, results];
    

    % ======================= No Breed cleaning =======================
        [ auxA, auxB ] = strtok(train_data(9), '/');
        no_breed_cleaning_A = dummyvar( auxA );
        no_breed_cleaning_B = dummyvar( auxB );
    % =================================================================

    train_dataset_colour = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, no_breed_cleaning_A, no_breed_cleaning_B, color_arr, pattern_arr, results];

    % ====================== Color cleaning ========================
        [ auxA, auxB ] = strtok(train_data(10), '/');
        no_colour_cleaningA = dummyvar( auxA );
        no_colour_cleaningB = dummyvar( auxB );
    % =================================================================

    train_dataset_breed = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr_A, breed_arr_B, no_colour_cleaningA, no_colour_cleaningB, results];

    train_dataset_no_colour_breed = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, no_breed_cleaning_A, no_breed_cleaning_B, no_colour_cleaningA, no_colour_cleaningB, results];

    train_dataset_normalized = eliminateNaN( train_dataset_normalized );
    train_dataset_colour = eliminateNaN( train_dataset_colour );
    train_dataset_breed = eliminateNaN( train_dataset_breed );
    train_dataset_no_colour_breed = eliminateNaN( train_dataset_no_colour_breed );

    %printDatasetToFile( train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed );

end