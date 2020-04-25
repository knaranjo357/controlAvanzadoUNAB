syms x1 x2 x3 u1 u2 u3 a b c d

f1 = -a*x2 - b*x1^2 + u1*u2;
f2 = -c*x3*x2 + u2^2 ;
f3 = -d*x3 + u3*x1 + u1;

    % F = funciones
    % X = estados
    % U = entradas
    % Y = salidas

F = [f1; f2; f3]        %cambiar segun numero de funciones
X = [x1; x2; x3]        %cambiar segun numero de estados
U = [u1; u2; u3]        %cambiar segun numero de entradas
Y = [x1;x3]             %cambiar segun numero de salidas

    % A= matriz de estados (simbolica)
    % B= matriz de entradas (simbolica)
    % C= matriz de salidas (simbolica)
    % D= matriz de transmision directa (simbolica)
    % n= numero de estados
    % p= numero de entradas
    % r= numero de salidas

[A,B,C,D,n,p,r]=matricesEstado(F,X,U,Y)

%PUNTO DE EQUILIBRIO

x10 = 2;
x20 = 4;
x30 = 4;
u20 = sqrt(c*x30*x20)
u10 = (a*x20 + b*x10^2)/u20
u30 = (d*x30 - u10)/x10
a1 = 2
b1 = 4
c1 = 1
d1 = 3

% MAXIMO ARRAY 10 ELEMENTOS
estados_x= [x1,x2,x3] 
salidas_u= [u1,u2,u3] 

estados_x10= [x10,x20,x30]
salidas_u10= [u10,u20,u30]

parametros_simbolicos= [a,b,c,d]
parametros_numericos= [a1,b1,c1,d1]

    % AL= matriz de estados (salidas y estados)
    % BL= matriz de entradas (salidas y estados)
    % CL= matriz de salidas (salidas y estados)
    % DL= matriz de transmision directa (salidas y estados)

    % ALn= matriz de estados (numericamente)
    % BLn= matriz de entradas (numericamente)
    % CLn= matriz de salidas (numericamente)
    % DLn= matriz de transmision directa (numericamente)

    [AL,BL,CL,DL,ALn,BLn,CLn,DLn]= matricesEstado_inpout_num (estados_x, salidas_u, estados_x10, salidas_u10, parametros_simbolicos, parametros_numericos,A,B,C,D)

    %ESPACIO DE ESTADOS
    sys =ss(ALn,BLn,CLn,DLn)
    %POLOS/ VALORES REALES
    polos=eig(ALn)

    %% CONTROLABILIDAD
    [rango,esControlable]= controlabilidad (sys)

%% CONTROLADOR LQR
Q = diag([1 1 1 50 20])%tama�o n + r
R = diag([0.1 0.1 0.1])%tama�o n

    [Kest,Ki,sysLQR_lc,sys_u,polosLQR]= controladorLQR (sys,Q,R)
    %%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
    graf_LQR(sysLQR_lc, sys_u)
    



        