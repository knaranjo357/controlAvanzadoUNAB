function [Kestc,Kic,sysLQR_lc_c,sys_u_c,polosLQR_c]= controladorLQR_Continua(sys,Q,R)
    [n,p]= size(sys.B)
    [r,n]= size(sys.C)

    [K,S,E] = lqi(sys,Q,R)
    Kestc = K(:,1:n)
    Kic = -K(:,n+1:end)
    
        AA = [sys.A - sys.B*Kestc, sys.B*Kic;
             -sys.C + sys.D*Kestc, -sys.D*Kic]
        BB = [zeros(n,r);
              eye(r)];
        CC = [sys.C - sys.D*Kestc, sys.D*Kic]
        DD = zeros(r,r);
        CC1 = [-Kestc Kic];
        DD1 = zeros(p,r);
    
    sysLQR_lc_c = ss(AA,BB,CC,DD)
    sys_u_c = ss(AA,BB,CC1,DD1)
    polosLQR_c=eig(AA)


end