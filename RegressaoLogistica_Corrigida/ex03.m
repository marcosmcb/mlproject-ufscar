%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Exercicio 3 - Regressao logistica
%
%  Instrucoes
%  ----------
%
%  Este arquivo contem o codigo que auxiliara no desenvolvimento do
%  exercicio. Voce precisara completar as seguintes funcoes:
%
%     sigmoid.m
%     funcaoCusto.m
%     predicao.m
%     funcaoCustoReg.m
%
%  Voce nao podera criar nenhuma outra funcao. Apenas altere as rotinas
%  fornecidas.
%

%% Inicializacao
clear ; close all; clc

%% Carrega os dados
fprintf('Carregando os dados...\n\n');
load('ex03Dados1.mat');

%% ================= Parte 1: Visualizacao dos Dados ====================
%  Muitas vezes a visualizacao dos dados auxilia na interpretacao dos dados
%  e como eles estao distribuidos.
%

fprintf(['Plotando dados...\n']);

visualizarDados(X, y);

hold on;

% Insere titulo, legenda e eixos
title('Plot 2D da base de dados Iris');
legend('Iris Setosa (y=1)','Iris Versicolour (y=0)');
xlabel('Comprimento da p�tala (cm)');
ylabel('Largura da p�tala (cm)');

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ============ Parte 2: Calculo do Custo e do Gradiente ============
%  Nesta etapa, voce precisara implementar a funcao custo e o metodo do
%  gradiente para a regressao logistica. Complete o codigo funcaoCusto.m

%  Configura a matriz apropriadamente e adiciona uns na primeira coluna
[m, n] = size(X);

X = [ones(m, 1) X];

%  Inicializa os parametros que serao ajustados
theta_inicial = zeros(n + 1, 1);

%  VOCE PRECISA COMPLETAR O CODIGO SIGMOID.M e FUNCAOCUSTO.M
%  Calcula e imprime o custo inicial e o gradiente
[custo, grad] = funcaoCusto(theta_inicial, X, y);

fprintf('\n\nCusto para theta inicial (zeros) = %f\n', custo);
fprintf('Gradiente para theta inicial (zeros) = \n');
fprintf(' %f \n', grad);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ============= Parte 3: Otimizacao avancada usando fminunc  =============
%  Nesta etapa, usaremos a funcao do Matlab/Octave (fminunc) para minimizar
%  o valor de theta

%  Definicao das opcoes para fminunc
opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

%  Executa fminunc para encontrar o theta otimo
%  A funcao retornara theta e o custo 
[theta, custo] = ...
	fminunc(@(t)(funcaoCusto(t, X, y)), theta_inicial, opcoes);

%  Imprime o valor de theta e o custo
fprintf('\nCusto para theta otimo encontrado por fminunc: %f\n', custo);
fprintf('theta: \n');
fprintf(' %f \n', theta);

% Plota o limite de decisao
plotarLimiteDecisao(theta, X, y);

legend('Iris Setosa (y=1)','Iris Versicolour (y=0)','Classificador');

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;

%% ============== Parte 4: Predicao e Desempenho ==============
%
%  Apos ajustados os parametros thetas, voce podera usar o classificador
%  para predizer a classe de novos dados.
%
%  Alem disso, voce podera calcular a acuracia do modelo sobre a base de 
%  treinamento.
%
%  VOCE PRECISA COMPLETAR O CODIGO PREDICAO.M

%  Prediz a probabilidade de uma Iris com comprimento de petala igual a 
%  5.5 cm e largura igual a 3.2 pertencer a classe Setosa (y=1) 

prob = sigmoid([1 5.5 3.2] * theta);
fprintf(['\n\nIris com petala de comprimento = 5.5 e largura = 3.2 \npertence a classe Setosa ' ...
         'com probabilidade igual a %f\n\n'], prob);

%  Calcula a acuracia do modelo sobre a base de treinamento.
p = predicao(theta, X);

fprintf('Acuracia na base de treinamento: %f\n', mean(double(p == y)) * 100);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ============= Parte 5: Predizendo a classe de novos dados =============

fprintf('\n\nPredizendo a classe de novos dados...\n\n')

x1_novo = input('Informe o comprimento da p�tala (em cm) ou -1 para SAIR: ');

while (x1_novo ~= -1)
    
    x2_novo = input('Informe a largura da p�tala (em cm): ');

    classe = predicao(theta, [1 x1_novo x2_novo]); % Faz a predicao usando theta encontrado
    
    if (classe)
        fprintf('Classe = Iris Setosa (y = 1)\n\n');
    else
        fprintf('Classe = Iris Versicolour (y = 0)\n\n');
    end
    
    x1_novo = input('Informe o comprimento da p�tala (em cm) ou -1 para SAIR: ');
end



%% ============== Parte 6: Carrega exemplo com outros dados ===============
%  Testa o algoritmo com exemplo mais complexo.
%

clear; close all;

%% Carrega novos dados

fprintf('\nCarregando exemplo mais complexo...\n\n');
load('ex03Dados2.mat');

visualizarDados(X, y);

hold on;

% Insere titulo, legenda e eixos
title('Plot 2D da base de dados Iris');
legend('Iris Virginica (y=1)','Iris Versicolour (y=0)');
xlabel('Comprimento da p�tala (normalizado)');
ylabel('Largura da p�tala (normalizado)');

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% =========== Parte 7: Regressao Logistica com Regularizacao ============
%  Nesta etapa, eh carregada uma base dados cujos pontos nao podem ser
%  separados linearmente. Contudo, voce pode continuar usando regressao 
%  logistica para classificar os dados.
%
%  Para produzir um classificador nao linear eh necessario introduzir mais
%  atributos (particularmente, atributos polinomiais)
%

% Adiciona atributos polinomiais calculados a partir dos atributos
% originais

% atributosPolinomiais adiciona novas colunas que correspondem a atributos
% polinomiais
X = atributosPolinomiais(X(:,1), X(:,2));

% Inicializa os parametros que serao ajustados
theta_inicial = zeros(size(X, 2), 1);

% Configura parametro de regularizacao lambda igual a 1
lambda = 1;

% Calcula e exibe custo inicial e gradiente para regressao logistica com
% regularizacao

%  VOCE PRECISA COMPLETAR O CODIGO FUNCAOCUSTOREG.M
[custo, grad] = funcaoCustoReg(theta_inicial, X, y, lambda);

fprintf('\n\nCusto para theta inicial (zeros): %f\n', custo);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ============= Parte 8: Regularizacao e desempenho =============
%  Nesta etapa, voce pode testar diferente valores de lambda e verificar
%  como a regularizacao afeta o limite de decisao
%

% Inicializa os parametros que serao ajustados
theta_inicial = zeros(size(X, 2), 1);

% Configura o parametro regularizacao lambda igual a 1
lambda = 1;

% Configura opticoes
opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

% Otimiza o gradiente
[theta, J, exit_flag] = ...
	fminunc(@(t)(funcaoCustoReg(t, X, y, lambda)), theta_inicial, opcoes);

% Plota limites de classificacao
plotarLimiteDecisao(theta, X, y);
legend('Iris Virginica (y=1)','Iris Versicolour (y=0)','Classificador');

% Calcula acuracia obtida na base de treinamento
p = predicao(theta, X);

fprintf('Acuracia na base de treinamento: %f\n', mean(double(p == y)) * 100);

fprintf('\nPrograma pausado. Pressione enter para continuar.\n');
pause;


%% ============= Parte 9: Predizendo a classe de novos dados =============

fprintf('\n\nPredizendo a classe de novos dados...\n\n')

x1_novo = input('Informe o comprimento da p�tala (normalizado) ou -1 para SAIR: ');

while (x1_novo ~= -1)
    
    x2_novo = input('Informe a largura da p�tala (normalizado): ');
    x_novo = atributosPolinomiais(x1_novo, x2_novo);

    classe = predicao(theta, x_novo); % Faz a predicao usando theta encontrado
    
    if (classe)
        fprintf('Classe = Iris Virginica (y = 1)\n\n');
    else
        fprintf('Classe = Iris Versicolour (y = 0)\n\n');
    end
    
    x1_novo = input('Informe o comprimento da p�tala (em cm) ou -1 para SAIR: ');
end



%% Finalizacao
clear; close all;