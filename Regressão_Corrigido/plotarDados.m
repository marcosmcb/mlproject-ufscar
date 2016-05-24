function plotarDados(x, y)
%PLOTARDADOS Plota os pontos de dados x e y em uma nova figura
%   PLOTARDADOS(x,y) plota pontos de dados e seta os rotulos x e y da
%   figura com "Populacao" e "Resultado orcamentario", respectivamente.


figure; % abre uma nova figura em uma janela

% ====================== ESCREVA O SEU CODIGO AQUI ======================
% Instrucoes: Plota os dados de treinamento em um grafico usando os comandos 
%               "figure" e "plot". Seta o rotulo dos eixos usando os comandos
%               "xlabel" e "ylabel". Assuma que a populacao e o resultado 
%               orcamentario sao passados nas variaveis x e y, como 
%               argumentos desta funcao.
%
% Dica: Voce pode usar a opcao 'bx' do comando plot para obter simbolos que
%       parecem xis azuis. Alem disso, voce pode aumentar o tamanhos
%       dos simbolos usando plot(..., 'bx', 'MarkerSize', 10);

plot(x, y, 'bx','LineWidth', 1.5, 'MarkerSize', 5);

title('População vs Resultado Orçamentário');
xlabel('População (x 10.000 Pessoas)');
ylabel('Resultado Orçamentário (x R$ 100.000,00)');
%hold on;

% =============================================================

end
