function [r0,r1] = cuadMin(Signal)
%% cuadMin
%   Realiza una regresion lineal mediante un ajuste por cuadrados
%   minimos.
%
%
%   Inputs: Senal a procesar.
%   Output: r0 y r1 son los coeficientes de una recta de ajuste definida 
%           como f(x) = r0+r1*x

    %% Coordenadas
    Xi = 1:length(Signal.amplitudvector);
    Yi = Signal.amplitudvector;
    
    %% Matriz de coeficientes
    
    A(1,1) = length(Xi);
    A(1,2) = sum(Xi);
    A(2,1) = A(1,2);
    A(2,2) = sum(Xi.^2);
    %% Matriz de resultados
    
    B(1,1) = sum(Yi);
    B(2,1) = sum(Xi.*Yi);
    
    %% Calculo de r0 y r1
    
    r = inv(A)*B;
    r0 = r(1,1);
    r1 = r(2,1);
end
   