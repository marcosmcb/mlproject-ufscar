function plotarLimiteDecisao(theta, X, y)
%PLOTALIMITEDECISAO Plota os pontos do limite de decisao

if size(X, 2) <= 3
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    plot(plot_x, plot_y,'g','LineWidth',2);
    
    axis([4, 7, 2, 4.5])
else
    
    u = linspace(-1, 1.5, 50);
    v = linspace(-1, 1.5, 50);
    
    z = zeros(length(u), length(v));
    
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = atributosPolinomiais(u(i), v(j))*theta;
        end
    end
    z = z';

    contour(u, v, z, [0, 0], 'LineWidth', 2)
end
hold off

end
