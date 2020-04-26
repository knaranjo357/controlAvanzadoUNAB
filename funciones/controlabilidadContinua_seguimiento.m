function [Mc,rango,esControlable]= controlabilidadContinua_seguimiento (sys)


    [n,p]= size(sys.B)
    [r,n]= size(sys.C)

Ahat = [sys.A zeros(n,r);
        sys.C zeros(r,r)];
Bhat = [sys.B;
        -sys.D]    
Mc = ctrb(Ahat,Bhat)

rango=rank(Mc)
%% el rango tiene que ser igual a n+r para que el sistema sea controlable
    if rango == n+r
        esControlable=true
    else
        esControlable=false
    end

end