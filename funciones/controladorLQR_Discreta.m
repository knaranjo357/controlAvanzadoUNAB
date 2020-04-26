function [Kestd,Kid,sys_LQR_lc_d,sys_u_d,polosLQR_d]= controladorLQR_Discreta (sysd,Q,R,Tm)
    [n,p]= size(sysd.B)
    [r,n]= size(sysd.C)

GLn = sysd.a
HLn = sysd.b
CLn = sysd.c

Ghat = [GLn, zeros(n,r);
        -CLn*GLn, eye(r)]
Hhat = [HLn;
        -CLn*HLn]
    
    
[K,S,E] = dlqr(Ghat,Hhat,Q,R)
Kestd = K(:,1:n)
Kid = -K(:,n+1:end)

AA = [GLn - HLn*Kestd, HLn*Kid;
     -CLn*GLn + CLn*HLn*Kestd ,eye(r)-CLn*HLn*Kid]
BB = [zeros(n,r);
      eye(r)]
CC = [CLn, zeros(r,r)]
DD = zeros(r,r);

sys_LQR_lc_d = ss(AA,BB,CC,DD,Tm)

    % Acción de control
CC1 = [-Kestd Kid]
CC1 = -K
DD1 = zeros(p,r);
sys_u_d = ss(AA,BB,CC1,DD1,Tm)
polosLQR_d= eig(AA)

end