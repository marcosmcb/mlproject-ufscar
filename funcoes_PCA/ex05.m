%% Nome: Marcos Cavalcante Barboza, RA: 408336


%clear ; close all; clc


%% =============== Parte 2: Principal Component Analysis ===============

%  Voce precisara implementar o PCA. Para isso, complete o arquivo pca.m

fprintf('\nExecutando PCA na base de dados.\n\n');

X = trainDatasetNormalized;

%  Antes de aplicar o PCA, normalize os valores de X
[X_norm, media, desvio] = normalizarAtributos( X );

%  Executa o PCA
[U, S] = pca(X_norm);

%  Plota os autovetores centralizados. As linhas indicam as direcoes de
%  maxima variacao na base de dados.
hold on;
plotarLinha(media, media + 1.5 * S(1,1) * U(:,1)', '-k', 'LineWidth', 2);
plotarLinha(media, media + 1.5 * S(2,2) * U(:,2)', '-k', 'LineWidth', 2);
hold off;

fprintf('Primeiro autovetor: \n');
fprintf(' U(:,1) = %f %f \n', U(1,1), U(2,1));
fprintf('\n(Se o PCA estiver correto, esperam-se os valores -0.707107 -0.707107)\n');

fprintf('\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;


%% ================= Parte 3: Reducao de Dimensionalidade =================
%  O proximo passo eh realizar a projecao do dado usando os primeiros k
%  autovetores. O programa plotara o dados em uma dimensionalidade
%  reduzida.
%
%  Voce precisara completar a funcao projetarDados.m
%
fprintf('\nReducao de dimensionalidade aplicada na base de dados.\n\n');

%  Plota a base normalizada (obtida do PCA)
plot(X_norm(:, 1), X_norm(:, 2), 'bo');
axis([-4 3 -4 3]); axis square

%  Projeta os dadados na dimensao K=1
K = 1;
Z = projetarDados(X_norm, U, K);
fprintf('Projecao da primeira amostra: %f\n', Z(1));
fprintf('\n(espera-se um valor aproximadamente igual a 1.481274)\n\n\n');

X_rec  = reconstruirDados(Z, U, K);
fprintf('Aproximacao da primeira amostra: %f %f\n', X_rec(1, 1), X_rec(1, 2));
fprintf('\n(espera-se um valor aproximadamente igual a -1.047419 -1.047419)\n\n');

%  Plota linhas conectando os pontos projetos ao pontos originais
hold on;
plot(X_rec(:, 1), X_rec(:, 2), 'ro');
for i = 1:size(X_norm, 1)
    plotarLinha(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
hold off

fprintf('\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;

% Impressao de tabela de valores originais, projetados e reconstruidos
fprintf('i \t Original (X) \t\t Projetado (Z) \t Reconstruido (X_rec)\n');
fprintf('- \t ------------ \t\t ------------- \t --------------------\n');
for i=1:size(X,1)
   fprintf('%d \t [%f %f] \t [%f] \t [%f %f]\n', i, X(i,1), X(i,2), Z(i), X_rec(i,1), X_rec(i,2));   
end


fprintf('\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;

%% =============== Parte 4: Carrega e visualiza dados faciais =============
%
fprintf('\nCarregando base de dados de faces...\n\n');

%  Carrega base de dados de faces
load ('ex05Faces.mat')

%  Exibe as primeiras 100 faces da base
exibirImagem(X(1:100, :));

fprintf('\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;

%% =============== Parte 5: PCA na base de Faces  ======================
%  Roda PCA e visualiza os autovetores que neste caso sao autofaces
%  Exibe as 36 primeiras autofaces.
%
fprintf(['\nExecutando PCA na base de faces.\n']);

%  Aplica normalizacao nos dados antes de aplicar PCA
[X_norm, media, desvio] = normalizarAtributos(X);

%  Executa o PCA
[U, S] = pca(X_norm);

%  Visualiza as 36 primeiras autofaces
exibirImagem(U(:, 1:36)');

fprintf('\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;


%% =========== Parte 6: Reducao de dimensionalidade da faces ==============
%  Projeta as imagens usando os primeiro k autovetores 
fprintf('\nReducao de dimensionalidade da base de faces.\n\n');

K = 100;
Z = projetarDados(X_norm, U, K);

fprintf('Dados projetados (Z) tem tamanho igual a: ')
fprintf('%d ', size(Z));

fprintf('\n\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;

%% ======= Parte 7: Visualizacao das imagens apos PCA =======
%  Projeta as imagens usando os primeiros K autovetores e visualiza apenas
%  K dimensoes.
%  Compara a imagem original com a reduzida.

fprintf('\nVisualizando dados projetados.\n\n');

K = 100;
X_rec  = reconstruirDados(Z, U, K);

% Plota dados normalizados
subplot(1, 2, 1);
exibirImagem(X_norm(1:100,:));
title('Dados originais');
axis square;

% Plota dados reconstruidos com apenas K autofaces
subplot(1, 2, 2);
exibirImagem(X_rec(1:100,:));
title('Dados reconstruidos');
axis square;

fprintf('\nPrograma pausado. Pressione enter para continuar.\n\n');
pause;
