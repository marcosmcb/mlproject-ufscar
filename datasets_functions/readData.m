function [train_matrix, test_matrix] = readData( )

    train_arq = fopen(fullfile('./datasets_originals', 'train.csv'));
    train_matrix = textscan( train_arq, '%s%s%s%s%s%s%s%s%s%s', 'delimiter', ',', 'headerlines', 1);
    
    test_arq = fopen(fullfile('./datasets_originals', 'test.csv'));
    test_matrix = textscan( test_arq, '%s%s%s%s%s%s%s%s%s%s', 'delimiter', ',', 'headerlines', 1);
    
end
