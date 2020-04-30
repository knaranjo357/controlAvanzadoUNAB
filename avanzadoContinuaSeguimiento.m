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
%bodemag(sys)
                %criterio a -3db
%wn                
                %criterio a -40db
%wn                
            %Tiempo de establecimiento
Ts=1
numeroMuestras=100
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
        
        %si el sistema presenta ganancia de velocidad o aceleracion
        %se tienen que sacar respectivamente
        K = dcgain(Gs)
        RGA = K.*pinv(K)'
       
            %DISCRETA
            Gz = tf(sysd)
            Kz = dcgain(Gz)
            RGAz = Kz.*pinv(Kz)'
            


%% CONTROLABILIDAD SEGUIMIENTO    %% CONTROLABILIDAD SEGUIMIENTO  %% CONTROLABILIDAD SEGUIMIENTO 
    %el rango tiene que tener un tamaño n+r
        %% CONTINUA
        [Mc,rango,esControlable_c]= controlabilidadContinua_seguimiento (sys)
        %% DISCRETA
        [Mcd,rangod,esControlable_d]= controlabilidadDiscreta_seguimiento (sysd)

%% CONTROLABILIDAD PUNTO DE EQUILIBRIO %% CONTROLABILIDAD PUNTO DE EQUILIBRIO %% CONTROLABILIDAD PUNTO DE EQUILIBRIO
    %el rango tiene que tener un tamaño n


%% CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
% CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
% CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--

%% CONTROLADOR PID 1-DOF --CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
    %%     CONTINUA

    %%     DISCRETA

%% CONTROLADOR PID 2-DOF  --CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
    %%     CONTINUA

    %%     DISCRETA

%% CONTROLADOR POLOS REALES  --CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
    %%     CONTINUA



    %%     DISCRETA
ts = 1;
s1 = -4/ts
Polc = [s1, 1.2*s1, 5*s1, 5*s1, 6*s1]
    Pold = exp(Tm*Polc)
    delta = diag(Pold)  % Matriz cuadrada de n+r
% Grand = 2*rand(p,n+r)-1;
Grand = [0.412092176039218 -0.907657218737692 0.389657245951634 -0.931107838994183 0.531033576298005;-0.936334307245159 -0.805736437528305 -0.365801039878279 -0.122511280687204 0.590399802274126;-0.446154030078220 0.646915656654585 0.900444097676710 -0.236883085813983 -0.626254790891243];
   
    [porKes_d,porKi_d,por_sys_lc_d,por_sys_lc_u_d]= controlPolosReales_d (sysd, delta,Grand,Tm)
    
%% CONTROLADOR POLOS COMPLEJOS  --CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
    %%     CONTINUA



    %%     DISCRETA
sysd = sysd;
ts = 1;
Tm = Tm
Mp = 0.1
Polc = [s1, conj(s1), 2*real(s1), 5*real(s1), 6*real(s1)]                           % Matriz cuadrada de n+r
Pold = exp(Tm*Polc)
delta = [   real(Pold(1))   imag(Pold(1))       0               0           0;  
            imag(Pold(2))   real(Pold(2))       0               0           0;
            0               0                   Pold(3)         0           0;
            0               0                   0               Pold(4)     0;
            0               0                   0               0           Pold(5)]
%Grand = 2*rand(p,n+r)-1;
Grand = [-0.300032468030383 0.232089352293278 0.661657255792582 0.834387327659620 0.507458188556991;-0.606809499137584 -0.0534223021945415 0.170528182305449 -0.428321962359253 -0.239108306049287;-0.497832284047938 -0.296680985874007 0.0994472165822791 0.514400458221443 0.135643281450442];
        
    [pocKesd,pocKid,pocsys_new,pocsys_u_d,pocpolos] = controlPolosComplejos_d (sysd, delta,Grand,Tm)    


%% CONTROLADOR OPTIMO LQR  --CONTROLADORES SEGUIMIENTO--CONTROLADORES SEGUIMIENTO--
    %% CONTINUA
Qc = diag([1 1 1 10 10])%tamaño n + r
Rc = diag([0.1 0.1 0.1])%tamaño n


            [lqrKest_c,lqrKi_c,lqr_sysLQR_lc_c,lqrsys_u_c,polosLQR_c]= controladorLQR_Continua(sys,Qc,Rc)
            %%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
%graficas_step_u (lqr_sysLQR_lc_c, lqrsys_u_c)

    %% DISCRETA
Qd = diag([1 1 1 0.1 0.1])%tamaño n + r
Rd = diag([10 10 10])%tamaño n
            [lqrKest_d,lqrKi_d,lqrsys_lc_d,lqrsys_u_d,polosLQR_d]= controladorLQR_Discreta (sysd,Qd,Rd,Tm)
% graficas_step_u (lqrsys_lc_d, lqrsys_u_d)

%%      
















xini = [0.2; 0.6; 0.1]



%% CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--
% CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--
% CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--

%% CONTROLADOR PID 1-DOF --CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--

%% CONTROLADOR POLOS REALES --CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--
    %% CONTINUA

    %% DISCRETA
    
ts = 1.5
    Tm = Tm
    xini= xini
    s1 = -4/ts
Polc = [s1, 2*s1, 4*s1] % vector de n
    Pold = exp(Tm*Polc)
    delta = diag(Pold)  % Matriz cuadrada de n
%Grand = 2*rand(p,n)-1;
Grand=[0.929777070398553,0.9914333896485891,-0.716227322745569;-0.684773836644903,-0.0292487025543176,-0.156477434747450;0.941185563521231,0.600560937777600,0.831471050378134]


    %controlador
    [K,sys_new,sys_u]= controlPolosReales_d_ptoEquilibrio (sysd, delta, Grand)
    
    %grafica
    graficas_step_u_puntoEquilibrio (sys_new, sys_u, xini)
    
%% CONTROLADOR POLOS COMPLEJOS --CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--
    %% CONTINUA

    %% DISCRETA
ts = 1.5;
Mp = 0.1
        Tm = Tm
        xini= xini
        zita = abs(log(Mp))/sqrt(pi^2+(log(Mp))^2);
        wn = 4/(zita*ts)
        wd = wn*sqrt(1-zita^2)
        %polo dominante
        s1 = -zita*wn + j*wd
    Polc = [s1, conj(s1), 4*real(s1)]                   % vector de n
        Pold = exp(Tm*Polc)
    delta = [   real(Pold(1))   imag(Pold(1))   0;      % Matriz cuadrada de n
                imag(Pold(2))   real(Pold(2))   0;
                0               0               Pold(3)]
% Grand = 2*rand(p,n)-1;
Grand = [0.584414659119109 -0.928576642851621 0.357470309715547;0.918984852785806 0.698258611737554 0.515480261156667;0.311481398313174 0.867986495515101 0.486264936249832];
    
    %controlador
    [K,sys_new,sys_u]= controlPolosComplejos_d_ptoEquilibrio (sysd, delta, Grand)
    %grafica
    graficas_step_u_puntoEquilibrio (sys_new, sys_u, xini)
%% CONTROLADOR OPTIMO LQR --CONTROLADORES PUNTO DE EQUILIBRIO--CONTROLADORES PUNTO DE EQUILIBRIO--
    %% CONTINUA

    %% DISCRETA
Q = diag([2 0.1 0.8]) % Matriz diagonal de tamaño n+r
R = diag([10 10 1])           % Matriz diagonal de tamaño p
    xini = xini
    %controlador
    [K,sys_new,sys_u]= controlLQR_d_ptoEquilibrio (sysd,Q,R)
    
    %grafica
    graficas_step_u_puntoEquilibrio (sys_new, sys_u, xini)
