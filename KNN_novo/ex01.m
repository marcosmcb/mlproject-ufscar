%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%

%% Inicializacao
clear ; close all; clc

% ============================ Dados ===========================
    fprintf('Carregando os dados...[1/5]\n\n');

    train_matrix = load('../datasets_normal&clean/datasetNormalAndCleanWithGroupOfBreedsAndColors.csv');

    [sizeM, sizeN] = size(train_matrix);

    %Faz o reverso do dummyvar
    [results, ~] = find(train_matrix(:, sizeN-4:sizeN)');
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% ========================= PARAMETERS =========================
    fprintf('Escolha do Número K...[2/5]\n\n');
    %fscanf('%d', K); %-K-NN
    K = floor(sqrt(sizeM));%floor(sqrt(sizeM)/10);%floor(sizeM*0.2);%floor(sqrt(sizeM));
    %Porcentagem da base que sera usada 
    pTreino = 30;
    pTeste = 100 - pTreino;
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


dados = train_matrix(:, 1:sizeN-5);
dados(:,sizeN-4) = results;
[sizeM_norm, sizeN_norm] = size(dados);
numRounds = floor(100/pTreino);
sizeFold = floor(pTreino/100 * sizeM);
partialResults = zeros(numRounds, sizeM-sizeFold);
indexes = 1:sizeM;
treino = zeros(sizeFold, sizeN_norm);
test = zeros(sizeM - sizeFold, sizeN_norm);

acertos = [0 0 0];

for k=1:numRounds
    % ========================== FOLD ==============================
        fprintf('Preparação do Fold...[3/5]\n\n');

        treinoIDX = indexes( ( (k-1) * sizeFold) + 1 : ((k) * sizeFold));
        testIDX = setdiff(indexes, treinoIDX);
        for i=1:sizeFold
            treino(i,:) = dados(treinoIDX(i), :);
        end
        for i=1:sizeM - sizeFold
            test(i,:) = dados(testIDX(i), :);
        end
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




    % ======================== CALCULATION =========================
        fprintf('Calculo do Vizinho...[4/5]\n\n');
        %  Voce devera completar essa funcao.
        %[y, ind_viz] = knn_calc(x_teste_norm, X_norm, Y, K);

        for i=1:sizeM-sizeFold
            [y, ~] = knn_calc(test(i,1:sizeN_norm-1), treino(:,1:sizeN_norm-1), treino(:,sizeN_norm), K);
            fprintf('... [ %d <=> %d ] -  %.4f ...[%d/%d][%d] = [%d]\n\n', y, test(i, sizeN_norm), (((i / (sizeFold)) * 100 )), k, numRounds, i, (y == test(i, sizeN_norm)));
            partialResults(k,i) = y;
        end
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    acertos(k) = sum(partialResults(k,:) == test(k,sizeN_norm)');
end

% ======================== CALCULATION =========================
    fprintf('Resultados...[5/5]\n\n');
    fprintf('>>%.4f\n\n', mean(acertos));
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

