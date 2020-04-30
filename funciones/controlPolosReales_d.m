function [porKes_d,porKi_d,por_sys_lc_d,por_sys_lc_u_d]= controlPolosReales_d (sysd, delta,Grand,Tm)

[n,p]= size(sysd.B)
    [r,n]= size(sysd.C)

GLn = sysd.a
HLn = sysd.b
CLn = sysd.c

Ghat = [GLn, zeros(n,r);
        -CLn*GLn, eye(r)]
Hhat = [HLn;
        -CLn*HLn]
    
    X = lyap(Ghat, -delta, -Hhat*Grand);
    det(X)
    K = Grand*inv(X)
    porKes_d = K(:,1:n)
    porKi_d = -K(:,n+1:end)
    
    AA = [GLn - HLn*porKes_d, HLn*porKi_d;
         -CLn*GLn + CLn*HLn*porKes_d ,eye(r)-CLn*HLn*porKi_d]
    eig(AA)
    BB = [zeros(n,r);
          eye(r)]
    CC = [CLn, zeros(r,r)]
    DD = zeros(r,r);
    por_sys_lc_d = ss(AA,BB,CC,DD,Tm)
    

    % Acción de control
    CC1 = [-porKes_d porKi_d]
    CC1 = -K
    DD1 = zeros(p,r);
    por_sys_lc_u_d = ss(AA,BB,CC1,DD1,Tm)
end