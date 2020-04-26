syms x1 x2 x3 u1 u2 u3 
f1 = -x1*x2 + u2*u3;
f2 = -x2*x3 + (u1/u2);
f3 = -x3^2 + u1;

y1 = 2*x1 - x3;
y2 = 2*x2;

    % F = funciones
    % X = estados
    % U = entradas
    % Y = salidas

F = [f1; f2; f3]        %cambiar segun numero de funciones
X = [x1; x2; x3]        %cambiar segun numero de estados
U = [u1; u2; u3]        %cambiar segun numero de entradas
Y = [y1;y2]             %cambiar segun numero de salidas

    % A= matriz de estados (simbolica)
    % B= matriz de entradas (simbolica)
    % C= matriz de salidas (simbolica)
    % D= matriz de transmision directa (simbolica)
    % n= numero de estados
    % p= numero de entradas
    % r= numero de salidas

[A,B,C,D,n,p,r]=matricesEstado(F,X,U,Y)

%PUNTO DE EQUILIBRIO


u20 = 4;
u10 = 4;
u30 = 1;

x30 = sqrt(u10);
x20 = (u10/u20)/x30;
x10 = (-u20*u30)/(-x20);


% MAXIMO ARRAY 10 ELEMENTOS
estados_x= [x1,x2,x3] 
salidas_u= [u1,u2,u3] 

estados_x10= [x10,x20,x30]
salidas_u10= [u10,u20,u30]

parametros_simbolicos= []
parametros_numericos= []

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
    %FUNCION DE TRANSFERENCIA
    Gs = tf(sys)
    %POLOS/ VALORES REALES
    polosContinua=eig(ALn)
            polodominante = abs(max(polosContinua))
            ts=4/polodominante
    
numeroMuestras=40

            Tm=ts/numeroMuestras
    
    %% EN DISCRETA
    sysd = c2d(sys,Tm)
    polosDiscreta=eig(sysd.A)

    %% CONTROLABILIDAD
    [Mc,rango,esControlable]= controlabilidad (sys)

