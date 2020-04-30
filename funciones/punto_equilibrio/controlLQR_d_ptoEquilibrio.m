function [K,sys_new,sys_u]= controlLQR_d_ptoEquilibrio (sysd,Q,R)
    [n,p]= size(sysd.B)
    [r,n]= size(sysd.C)

GLn = sysd.a
HLn = sysd.b
CLn = sysd.c

[K,S,E] = dlqr(GLn,HLn,Q,R)
    
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