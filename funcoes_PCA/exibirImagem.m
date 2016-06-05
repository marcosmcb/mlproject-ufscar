function [h, display_array] = exibirDados(X, example_width)
%EXIBIRDADOS Plota dados 2D em um grid
%   [h, display_array] = EXIBIRDADOS(X, example_width) exibe dados 2D
%   armazenados em X em um grid. A funcao retorna a figura h e o vetor
%   se necessario.

% Define example_width automaticamente se nao for passado por parametro
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2)));
end

% Define imagem em tons de cinza
colormap(gray);

% Calcula numero de linhas e colunas
[m n] = size(X);
example_height = (n / example_width);

% Calcula numero de itens que serao exibidos
display_rows = floor(sqrt(m));
display_cols = ceil(m / display_rows);

% Preenchimento entre imagens
pad = 1;

% Configura display em branco
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad));

curr_ex = 1;
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		
		% Pega o valor maximo
		max_val = max(abs(X(curr_ex, :)));
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% Exibe a imagem
h = imagesc(display_array, [-1 1]);

% Retira os eixos
axis image off

drawnow;

end
