%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Máquina
%  Prof. Tiago A. Almeida
%
%  Exercicio 1 - Algoritmo dos K-vizinhos mais proximos
%
%  Instrucoes
%  ----------
%
%  Este arquivo contem o codigo que auxiliara no desenvolvimento do
%  exercicio. Voce precisara completar as seguintes funcoes:ns:
%
%     normalizacao.m
%     distancia.m
%     knn.m
%
%  Voce nao podera criar nenhuma outra funcao. Apenas altere as rotinas
%  fornecidas.
%

%% Inicializacao
clear ; close all; clc

%% ================= Parte 1: Visualizacao dos Dados ====================
%  Muitas vezes a visualizacao dos dados auxilia na interpretacao dos dados
%  e como eles estao distribuidos. Nesta etapa, voce precisa completar a
%  funcao de normalizacao dos atributos (normalizacao.m).
%
fprintf('Carregando os dados...\n\n');

% Carrega os dados do arquivo
load('ex01Dados.mat');

% Exibe a primeira amostra da base
fprintf('Primeira amostra da base sem normalizacao: [%2.4f %2.4f].\n\n', X(1,1), X(1,2));

% Plota os dados para visualizacao
visualizarDados(X,Y);

% Insere titulo, legenda e eixos
title('Plot 2D da base de dados Iris');
legend('Iris Setosa (+)','Iris Versicolour (-)');
xlabel('Comprimento da petala (cm)');
ylabel('Largura da petala (cm)');
hold on;

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;

%  Como a distancia entre as amostras pode ser influenciada pela escala
%  dos atributos, eh recomendavel que os atributos sejam normalizados de
%  forma tal que a media = 0 e desvio padrao = 1. 

% Voce devera completar a funcao abaixo para retornar os valores corretos 
[X_norm, mu, sigma] = normalizar(X);

% Exibe a primeira amostra da base e o valor esperado
fprintf('\n\nApos a normalizacao, espera-se que a primeira amostra seja igual a: [-0.8615 0.0326].\n');
fprintf('Primeira amostra da base apos normalizacao: [%2.4f %2.4f].\n\n', ... 
    X_norm(1,1), X_norm(1,2));

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ================= Parte 2: Cria um caso de teste ====================
%  Cria um caso de teste para ser classificado e plota a nova amostra
%

%  Definicao do primeiro caso de teste.
%-------------------
x_teste = [5.5 3.2]; %Voce pode testar outros valores
%-------------------


fprintf('\n\nPlotanto caso de teste: [%2.4f %2.4f].\n', x_teste(1,1), x_teste(1,2));

%  Visualizando o caso de teste junto com os dados
plot(x_teste(1, 1), x_teste(1, 2), 'ks', 'MarkerFaceColor', 'g', 'MarkerSize', 7);


%  Normaliza o caso de teste usando o valor de mu e sigma pre-calculado
x_teste_norm = (x_teste - mu)./sigma;

%  Exibe a primeira amostra da base e o valor esperado
fprintf('Apos a normalizacao, espera-se que a amostra de teste seja igual a: [0.0489 0.2422].\n');
fprintf('Amostra de teste normalizada: [%2.4f %2.4f].\n\n', ... 
    x_teste_norm(1), x_teste_norm(2));

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ================= Parte 3: Algoritmo K-Vizinhos ====================
%  Nesta etapa, o algoritmo do K-vizinhos devera ser implementado e testado
%  para predizer a classe de um novo atributo teste. Primeiro, voce devera
%  completar a funcao que calcula a distancia euclidiana entre dois
%  vetores quaisquer (distancia.m) e, posteriormente, o codigo referente ao
%  metodo do knn (knn.m).
%

%  Define a quantidade de vizinhos. Recomenda-se que seja impar (1, 3, ou 5)
%-----
K = 1; %Voce pode testar outros valores
%-----

%  Chama o algoritmo do k-vizinhos para predizer o rotulo da amostra teste.
%  Voce devera completar essa funcao.
[y, ind_viz] = knn(x_teste_norm, X_norm, Y, K);


%  Exibe o rotulo da amostra de teste esperado para K=1
fprintf('\n\nPara K=1, a resposta esperada e: 0 ==> Iris Versicolour.\n');

%  Exibe o rotulo da amostra de teste retornado pelo algoritmo KNN
fprintf('Segundo o KNN, a classe da amostra de teste e: %d ==> ', y);

%  Imprime a especie da planta de acordo com o rotulo informado
if (y == 0)
    fprintf('Iris Versicolour.\n');
else
    fprintf('Iris Setosa.\n');
end


fprintf('Plotanto o(s) %d-vizinho(s) mais proximo(s) usado(s) na classificacao.\n\n',K);

%  Visualizando o caso de teste junto com os dados
for i = 1:K
    if (Y(ind_viz(i)) == 1)
        plot(X(ind_viz(i), 1), X(ind_viz(i), 2), 'k+','LineWidth', 2, 'MarkerSize', 7);
    else
        plot(X(ind_viz(i), 1), X(ind_viz(i), 2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7);
    end
end

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%  Libera a figura
hold off;


%% ================= Parte 4: Exemplo com outros dados ====================
%  Testa o algoritmo com exemplo mais complexo.
%
clear ; close all;

fprintf('\n\n------------------ EXEMPLO 2 ---------------------------\n\n');

fprintf('\nPlotando dados...\n');

% Carrega os dados do arquivo
load('ex01Dados2.mat');

% Plota os dados para visualizacao
visualizarDados(X,Y);

% Insere titulo, legenda e eixos
title('Plot 2D da base de dados Iris');
legend('Iris Virginica (+)','Iris Versicolour (-)');
xlabel('Comprimento da petala (cm)');
ylabel('Largura da petala (cm)');
hold on;

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;

%  Variaveis que deverao ser calculadas
[m,n] = size(X); % m = qtde de objetos e n = qtde de atributos por objeto

X_norm = zeros(m,n); % inicializa X_norm
mu = 1; % inicializa media
sigma = 1; % inicializa desvio padrao

% Normaliza os dados de X 
[X_norm, mu, sigma] = normalizar(X);


%  Definicao de outro caso de teste.
%-------------------
x_teste = [5.90 2.84]; %Voce pode testar outros valores
%-------------------

fprintf('\n\nPlotanto caso de teste: [%2.4f %2.4f].\n', x_teste(1,1), x_teste(1,2));

%  Visualizando o caso de teste junto com os dados
plot(x_teste(1, 1), x_teste(1, 2), 'ks', 'MarkerFaceColor', 'g', 'MarkerSize', 7);


%  Normaliza o caso de teste usando o valor de mu e sigma pre-calculado
x_teste_norm = (x_teste - mu)./sigma;


fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%  Define a quantidade de vizinhos. Recomenda-se que seja impar (1, 3, ou 5)
%-----
K = 1; %Voce pode testar outros valores
%-----

%  Chama o algoritmo do k-vizinhos para predizer o rotulo da amostra teste.
%  Voce devera completar essa funcao.
[y, ind_viz] = knn(x_teste_norm, X_norm, Y, K);


%  Exibe o rotulo da amostra de teste retornado pelo algoritmo KNN
fprintf('\n\nSegundo o KNN, a classe da amostra de teste e: %d ==> ', y);

%  Imprime a especie da planta de acordo com o rotulo informado
if (y == 0)
    fprintf('Iris Versicolour.\n');
else
    fprintf('Iris Virginica.\n');
end


fprintf('Plotanto o(s) %d-vizinho(s) mais proximo(s) usado(s) na classificacao.\n\n',K);

%  Visualizando o caso de teste junto com os dados
for i = 1:K
    if (Y(ind_viz(i)) == 1)
        plot(X(ind_viz(i), 1), X(ind_viz(i), 2), 'k+','LineWidth', 2, 'MarkerSize', 7);
    else
        plot(X(ind_viz(i), 1), X(ind_viz(i), 2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7);
    end
end

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%  Libera a figura
hold off;

%  Fecha figuras abertas
close all;


