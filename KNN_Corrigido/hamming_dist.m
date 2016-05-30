function D = hamming_dist(x, X)
[m, n] = size(X);  % Quantidade de objetos em X
D = zeros(m,1); % Inicializa a matriz de distancias D

for i=1:m
    max = 0;
    for j=1:n
        if(X(i,j) ~= x(j))
            max = max + 1;
        end
    end
    D(i) = max;
end

end