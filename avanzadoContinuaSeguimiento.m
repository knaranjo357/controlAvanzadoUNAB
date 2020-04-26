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

    
    %% REPRESENTACION DEL SISTEMA NUMERICAMENTE CONTINUA
    
        % CONTINUA
        %ESPACIO DE ESTADOS
        sys =ss(ALn,BLn,CLn,DLn)
        %FUNCION DE TRANSFERENCIA
        Gs = tf(sys)
        %POLOS/ VALORES REALES
        polos=eig(ALn)
        
%% DISCRETIZAR
            %para discretizar hay diferentes metodos
            
            %BODE
            bodemag(sys)
                %criterio a -3db
%wn                
                %criterio a -40db
%wn                
            %Tiempo de establecimiento
Ts=1
numeroMuestras=40
            Tm= Ts/numeroMuestras

    %% REPRESENTACION DEL SISTEMA NUMERICAMENTE DISCRETA
    sysd = c2d(sys,Tm)
    Gz= c2d(Gs,Tm)
    
    % GLn= matriz de estados (numericamente DISCRETA)
    % HLn= matriz de entradas (numericamente DISCRETA)
    
    % CLn= matriz de salidas (numericamente) IGUAL PARA DISCRETA Y CONTINUA
    % DLn= matriz de transmision directa (numericamente) IGUAL PARA DISCRETA Y CONTINUA 
    
    GLn = sysd.a
    HLn = sysd.b
    
%% COMPARACION CONTINUA Y DISCRETA

    grafComparacion_con_dis (sys, sysd)

    %% RGA
        %CONTINUA ---RECOMENDADO POR SENCILLEZ---
        K = dcgain(Gs)
        RGA = K.*pinv(K)'
       
            %DISCRETA
            Gz = tf(sysd)
            Kz = dcgain(Gz)
            RGAz = Kz.*pinv(Kz)'
            


    %% CONTROLABILIDAD SEGUIMIENTO
    [Mc,rango,esControlable]= controlabilidadContinua_seguimiento (sys)
    [Mcd,rangod,esControlabled]= controlabilidadDiscreta_seguimiento (sysd)

    %% CONTROLABILIDAD PUNTO DE EQUILIBRIO
%% CONTROLADOR PID 1-DOF
    %depende del numero de salidas que tengamos y su 
    %respectivo actuador que lo va a controlar
% y1c=Gs()
% u1c=Gs()
% Gsaliday1_entradau1= G(y1c,u1c)

%% CONTROLADOR PID 2-DOF

%% CONTROLADOR POLOS REALES


%% CONTROLADOR POLOS COMPLEJOS

    %% CONTROLADOR OPTIMO LQR
Q = diag([1 1 1 50 20])%tamaño n + r
R = diag([0.1 0.1 0.1])%tamaño n

    [Kest,Ki,sysLQR_lc,sys_u,polosLQR]= controladorLQR_Continua (sys,Q,R)
    %%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
    graf_LQR(sysLQR_lc, sys_u)
    



        
