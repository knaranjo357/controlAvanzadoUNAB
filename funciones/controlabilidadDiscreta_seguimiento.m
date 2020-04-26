function [Mcd,rangod,esControlabled]= controlabilidadDiscreta_seguimiento (sysd)
% sysd.A=GLn
% sysd.B=HLn
% sysd.C=CLn 
 
    [n,p]= size(sysd.B)
    [r,n]= size(sysd.C)

Ghat = [sysd.A, zeros(n,r);
        -sysd.C*sysd.A, eye(r)];
Hhat = [sysd.B;
        -sysd.C*sysd.B]    
Mcd = ctrb(Ghat,Hhat)

rangod=rank(Mcd)
%% el rango tiene que ser igual a n+r para que el sistema sea controlable

    if rangod == n+r
        esControlabled=true
    else
        esControlabled=false
    end

end