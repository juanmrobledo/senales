function [a0,a1] = cuadMin(x,y)
%% cuadMin
%   Realiza una regresion lineal mediante un ajuste por cuadrados
%   minimos.
%
%   [a0,a1] = cuadMin(x,y)
%
%   Inputs: x e y son coordenadas de cada muestra de la senal a procesar.
%   Output: a0 y a1 son los coeficientes de una recta de ajuste definida 
%           como a0+a1*x

   
    A = ones(length(x),2);
    A(:,2) = x;
    B = y;
    
    try
        coef = (A'*A)\(A'*B);
        a0 = coef(1);
        a1 = coef(2);
    catch
        switch length(x)==length(y)
            case 1                      %Si y es ingresado como vector columna
               B = B';
               coef = (A'*A)\(A'*B);
               a0 = coef(1);
               a1 = coef(2);
        end
    end
    X = min(x):0.1: max(x);
    Y = min(y):0.1: max(y);
    Y = a0 + a1*X;
    
    
 %% Visualizacion   
%     disp('a0=');
%     disp(a0);
%     disp('a1=');
%     disp(a1);
%     disp('coef=');
%     disp(coef);
%         
%     subplot(2,1,1); 
%     plot(x,y); 
%     title('Senal a Procesar');
%     xlim([min(x) max(x)]);
%     ylim([min(y) max(y)]);
%     
%     subplot(2,1,2); 
%     plot(X,Y);
%     title('Recta de Ajuste'); 
%     xlim([min(x) max(x)]);
%     ylim([min(y) max(y)]);
%     
end