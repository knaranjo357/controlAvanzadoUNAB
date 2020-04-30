function [pocKesd,pocKid,pocsys_new,pocsys_u_d,pocpolos] = controlPolosComplejos_d (sysd, delta,Grand,Tm)

GLn = sysd.a
HLn = sysd.b
CLn = sysd.c


    [n,p]= size(sysd.B)
    [r,n]= size(sysd.C)



Ghat = [GLn, zeros(n,r);
        -CLn*GLn, eye(r)]
Hhat = [HLn;
        -CLn*HLn]
    

    X = lyap(Ghat, -delta, -Hhat*Grand);
    det(X)
    K = Grand*inv(X)
    %salidas
    pocKesd = K(:,1:n)
    pocKid = -K(:,n+1:end)

%% Modelo lineal en lazo cerrado para seguimiento
    AA = [GLn - HLn*pocKesd, HLn*pocKid;
         -CLn*GLn + CLn*HLn*pocKesd ,eye(r)-CLn*HLn*pocKid]
    BB = [zeros(n,r);
          eye(r)]
    CC = [CLn, zeros(r,r)]
    DD = zeros(r,r);
pocsys_new = ss(AA,BB,CC,DD,Tm)

pocpolos=eig(AA)

    % Acción de control
    CC1 = [-pocKesd pocKid]
    CC1 = -K
    DD1 = zeros(p,r);
pocsys_u_d = ss(AA,BB,CC1,DD1,Tm)


end