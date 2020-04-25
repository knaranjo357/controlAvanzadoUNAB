function [rango,esControlable]= controlabilidad (sys)


    [n,p]= size(sys.B)
    [r,n]= size(sys.C)

Ahat = [sys.A zeros(n,r);
        sys.C zeros(r,r)];
Bhat = [sys.B;
        -sys.D]    
M = ctrb(Ahat,Bhat)

rango=rank(M)

    if rango == p+r
        esControlable=true
    else
        esControlable=false
    end

end