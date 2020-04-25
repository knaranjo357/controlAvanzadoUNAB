function [AL,BL,CL,DL,ALn,BLn,CLn,DLn]= matricesEstado_inpout_num (estados_x, salidas_u, estados_x10, salidas_u10, parametros_simbolicos, parametros_numericos,A,B,C,D)
    [np,estados_x_num]=size(estados_x)
    l1=estados_x_num+1

        for cl=l1:10
            estados_x(cl)=0
            estados_x10(cl)=0
        end

    [np,salidas_u_num]=size(salidas_u)
    l2=salidas_u_num+1

        for cl=l2:10
            salidas_u(cl)=0
            salidas_u10(cl)=0
        end

    [np,parametros_simbolicos_num]=size(parametros_simbolicos)
    l3=parametros_simbolicos_num+1
        for cl=l3:10
            parametros_simbolicos(cl)=0
            parametros_numericos(cl)=0
        end

    AL = subs(A,{estados_x(1),estados_x(2),estados_x(3),estados_x(4),estados_x(5),estados_x(6),estados_x(7),estados_x(8),estados_x(9),estados_x(10),salidas_u(1),salidas_u(2),salidas_u(3),salidas_u(4),salidas_u(5),salidas_u(6),salidas_u(7),salidas_u(8),salidas_u(9),salidas_u(10)},{estados_x10(1),estados_x10(2),estados_x10(3),estados_x10(4),estados_x10(5),estados_x10(6),estados_x10(7),estados_x10(8),estados_x10(9),estados_x10(10),salidas_u10(1),salidas_u10(2),salidas_u10(3),salidas_u10(4),salidas_u10(5),salidas_u10(6),salidas_u10(7),salidas_u10(8),salidas_u10(9),salidas_u10(10)})
    BL = subs(B,{estados_x(1),estados_x(2),estados_x(3),estados_x(4),estados_x(5),estados_x(6),estados_x(7),estados_x(8),estados_x(9),estados_x(10),salidas_u(1),salidas_u(2),salidas_u(3),salidas_u(4),salidas_u(5),salidas_u(6),salidas_u(7),salidas_u(8),salidas_u(9),salidas_u(10)},{estados_x10(1),estados_x10(2),estados_x10(3),estados_x10(4),estados_x10(5),estados_x10(6),estados_x10(7),estados_x10(8),estados_x10(9),estados_x10(10),salidas_u10(1),salidas_u10(2),salidas_u10(3),salidas_u10(4),salidas_u10(5),salidas_u10(6),salidas_u10(7),salidas_u10(8),salidas_u10(9),salidas_u10(10)})
    CL = subs(C,{estados_x(1),estados_x(2),estados_x(3),estados_x(4),estados_x(5),estados_x(6),estados_x(7),estados_x(8),estados_x(9),estados_x(10),salidas_u(1),salidas_u(2),salidas_u(3),salidas_u(4),salidas_u(5),salidas_u(6),salidas_u(7),salidas_u(8),salidas_u(9),salidas_u(10)},{estados_x10(1),estados_x10(2),estados_x10(3),estados_x10(4),estados_x10(5),estados_x10(6),estados_x10(7),estados_x10(8),estados_x10(9),estados_x10(10),salidas_u10(1),salidas_u10(2),salidas_u10(3),salidas_u10(4),salidas_u10(5),salidas_u10(6),salidas_u10(7),salidas_u10(8),salidas_u10(9),salidas_u10(10)})
    DL = subs(D,{estados_x(1),estados_x(2),estados_x(3),estados_x(4),estados_x(5),estados_x(6),estados_x(7),estados_x(8),estados_x(9),estados_x(10),salidas_u(1),salidas_u(2),salidas_u(3),salidas_u(4),salidas_u(5),salidas_u(6),salidas_u(7),salidas_u(8),salidas_u(9),salidas_u(10)},{estados_x10(1),estados_x10(2),estados_x10(3),estados_x10(4),estados_x10(5),estados_x10(6),estados_x10(7),estados_x10(8),estados_x10(9),estados_x10(10),salidas_u10(1),salidas_u10(2),salidas_u10(3),salidas_u10(4),salidas_u10(5),salidas_u10(6),salidas_u10(7),salidas_u10(8),salidas_u10(9),salidas_u10(10)})



    ALn = double(subs(AL,{parametros_simbolicos(1),parametros_simbolicos(2),parametros_simbolicos(3),parametros_simbolicos(4),parametros_simbolicos(5),parametros_simbolicos(6),parametros_simbolicos(7),parametros_simbolicos(8),parametros_simbolicos(9),parametros_simbolicos(10)},{parametros_numericos(1),parametros_numericos(2),parametros_numericos(3),parametros_numericos(4),parametros_numericos(5),parametros_numericos(6),parametros_numericos(7),parametros_numericos(8),parametros_numericos(9),parametros_numericos(10)}))
    BLn = double(subs(BL,{parametros_simbolicos(1),parametros_simbolicos(2),parametros_simbolicos(3),parametros_simbolicos(4),parametros_simbolicos(5),parametros_simbolicos(6),parametros_simbolicos(7),parametros_simbolicos(8),parametros_simbolicos(9),parametros_simbolicos(10)},{parametros_numericos(1),parametros_numericos(2),parametros_numericos(3),parametros_numericos(4),parametros_numericos(5),parametros_numericos(6),parametros_numericos(7),parametros_numericos(8),parametros_numericos(9),parametros_numericos(10)}))
    CLn = double(subs(CL,{parametros_simbolicos(1),parametros_simbolicos(2),parametros_simbolicos(3),parametros_simbolicos(4),parametros_simbolicos(5),parametros_simbolicos(6),parametros_simbolicos(7),parametros_simbolicos(8),parametros_simbolicos(9),parametros_simbolicos(10)},{parametros_numericos(1),parametros_numericos(2),parametros_numericos(3),parametros_numericos(4),parametros_numericos(5),parametros_numericos(6),parametros_numericos(7),parametros_numericos(8),parametros_numericos(9),parametros_numericos(10)}))
    DLn = double(subs(DL,{parametros_simbolicos(1),parametros_simbolicos(2),parametros_simbolicos(3),parametros_simbolicos(4),parametros_simbolicos(5),parametros_simbolicos(6),parametros_simbolicos(7),parametros_simbolicos(8),parametros_simbolicos(9),parametros_simbolicos(10)},{parametros_numericos(1),parametros_numericos(2),parametros_numericos(3),parametros_numericos(4),parametros_numericos(5),parametros_numericos(6),parametros_numericos(7),parametros_numericos(8),parametros_numericos(9),parametros_numericos(10)}))

end