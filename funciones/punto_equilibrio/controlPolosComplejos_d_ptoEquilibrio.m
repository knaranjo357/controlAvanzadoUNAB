function [K,sys_new,sys_u]= controlPolosComplejos_d_ptoEquilibrio (sysd, delta, Grand)
    [n,p]= size(sysd.B)
    [r,n]= size(sysd.C)

GLn = sysd.a
HLn = sysd.b
CLn = sysd.c

    X = lyap(GLn, -delta, -HLn*Grand);
    det(X)
    K = Grand*inv(X)
    
    %%lazo cerrado
AA = GLn-HLn*K
eig(AA)
BB = zeros(n,p)
CC = CLn-DLn*K
DD = zeros(r,p);
sys_new = ss(AA,BB,CC,DD,Tm)

% Acción de control
CC1 = -K;
DD1 = zeros(p,p);
sys_u = ss(AA,BB,CC1,DD1,Tm)


end