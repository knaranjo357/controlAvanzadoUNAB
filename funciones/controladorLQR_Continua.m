function [Kest,Ki,sysLQR_lc,sys_u,polosLQR]= controladorLQR_Continua(sys,Q,R)

    [n,p]= size(sys.B)
    [r,n]= size(sys.C)

    [K,S,E] = lqi(sys,Q,R)
    Kest = K(:,1:n)
    Ki = -K(:,n+1:end)
    
        AA = [sys.A - sys.B*Kest, sys.B*Ki;
             -sys.C + sys.D*Kest, -sys.D*Ki]
        BB = [zeros(n,r);
              eye(r)];
        CC = [sys.C - sys.D*Kest, sys.D*Ki]
        DD = zeros(r,r);
        CC1 = [-Kest Ki];
        DD1 = zeros(p,r);
    
    sysLQR_lc = ss(AA,BB,CC,DD)
    sys_u = ss(AA,BB,CC1,DD1)
    polosLQR=eig(AA)


end