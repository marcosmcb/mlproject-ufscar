function [ train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed, ...
	test_dataset_normalized] = normalizeDataset( train_data, test_data)

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

% Removes empty cells, noisy ones ('0 years') and transform the data
train_data = cleanDataSet( train_data, empty_arr, zeros_arr);

%% Start to actually normalize the dataset, the previous steps were performed to clean the dataset

[ages_arrNN] = normalizeAgeuponOutcome( train_data{8} );

% normalize age range
% MAY CAUSE PROBLEMS IN TEST DATA, be warned to preprocess it
ages_arr = zscore(ages_arrNN);


% 'With name' == 1 and 'without name' == 0
names_arr = normalizeNames( train_data{2} );

% With dog == 1 and cat == 0
animal_type_arr = normalizeAnimalType( train_data{6} );

%SexUponOutCome cleaning
sex_upon_out_come_arr = binarizeColumn( train_data(7) );

%Breed cleaning
[breed_arr_A, breed_arr_B, breedA_preDummy, breedB_preDummy] = normalizeBreed( train_data(9) , animal_type_arr);

%Color cleaning
[color_arr, pattern_arr] = splitColorAndPattern( train_data(10) );

%Classes normalization
%The columns are in this disposal:
%Return_to_owner | Euthanasia | Adoption | Transfer | Died
results = dummyvar( grp2idx( train_data{4} ) );

%% Final steps

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


%% Processing test_data

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( test_data{6} );

% Removes empty cells, noisy ones ('0 years') and transform the data
test_data = cleanDataSet( test_data, empty_arr, zeros_arr);


% Start to actually normalize the dataset, the previous steps were performed to clean the dataset

% to normalize the age column we need to adjust the cells not in train age range
biggestAge = max(ages_arrNN);
smallestAge = min(ages_arrNN);

ages_arr = normalizeAgeuponOutcomeTest( test_data{6}, biggestAge, smallestAge );

% normalize age range
ages_arr = zscore(ages_arr);

% 'With name' == 1 and 'without name' == 0
names_arr = normalizeNames( test_data{2} );

% With dog == 1 and cat == 0
animal_type_arr = normalizeAnimalType( test_data{4} );

%SexUponOutCome cleaning
sex_upon_out_come_arr = binarizeColumnTest( test_data(5) , train_data(7), sex_upon_out_come_arr);

%Breed cleaning
[~, sizeBreedA] = size(breed_arr_A);
[~, sizeBreedB] = size(breed_arr_B);
[breed_arr_A, breed_arr_B] = normalizeBreedTest( test_data(7) , animal_type_arr, breedA_preDummy, breedB_preDummy, sizeBreedA, sizeBreedB);

%Color cleaning
[color_arr, pattern_arr] = splitColorAndPattern( test_data(8) );


			% Final steps

% Create a Normalized and Clean Matrix (with breeds and colour normalization)
test_dataset_normalized = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr_A, breed_arr_B, color_arr, pattern_arr];

test_dataset_normalized = eliminateNaN( test_dataset_normalized );
toc;

%% Saving processesd datasets

fprintf('Salvando datasets processados em arquivo...\n');

% salva os dados na pasta raiz mesmo
save('processed_data.mat', 'train_dataset_normalized', 'train_dataset_colour', ... 
	'train_dataset_breed', 'train_dataset_no_colour_breed', 'test_dataset_normalized');

fprintf('Datasets salvos!\n');

end