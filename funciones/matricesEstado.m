function [A,B,C,D,n,p,r]= matricesEstado (F,X,U,Y)


% ENTRADAS
%
% F= funciones
% Y= Salidas
% U= entradas
% X= estados
%
%SALIDAS
%
%matrices de estado en continua
% A= matriz de estados
% B= matriz de entradas
% C=matriz de salidas
% D=matriz de transmision directa
%
% n= numero de estados
% r= numero de salidas
% p= numero de entradas
%
%

% MATRICES DE ESTADO EN CONTINUA MODELO NO LINEAL
    A = jacobian (F,X)
    B = jacobian (F,U)
    C = jacobian (Y,X)
    D = jacobian (Y,U)
% n, p , r
    [n,p]= size(B)
    [r,n]= size(C)

end