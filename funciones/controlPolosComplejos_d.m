
function [pocKesd,pocKid,pocsys_new,pocsys_u,pocpolos]= controlPolosComplejos_d (sysd,Tm,Mp,Grand,Delta)
% Diseño polos complejos
% necesito
% sys
% Tm
% Mp
% Grand
% Delta
    [n,p]= size(sysd.B)
    [r,n]= size(sysd.C)

GLn = sysd.a
HLn = sysd.b
CLn = sysd.c

Ghat = [GLn, zeros(n,r);
        -CLn*GLn, eye(r)]
Hhat = [HLn;
        -CLn*HLn]
    
    zita = abs(log(Mp))/sqrt(pi^2+(log(Mp))^2);
    wn = 4/(zita*ts)
    wd = wn*sqrt(1-zita^2)
    s1 = -zita*wn + j*wd
    
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
pocsys_u = ss(AA,BB,CC1,DD1,Tm)

    
end
