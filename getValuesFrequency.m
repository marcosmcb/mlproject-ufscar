function [wordCount, words, percentage] = getValuesFrequency( arr )

    [ words, ~, wordsIdx ] = unique( arr );
    nUniqueWords = length(words);
    [wordCount, countIdx] = hist( wordsIdx, unique(wordsIdx) );
    percentage = wordCount / sum(wordCount) * 100;

end