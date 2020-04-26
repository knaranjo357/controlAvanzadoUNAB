function [A,B]= grafComparacion_con_dis (sys, sysd)
 %%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
    A =figure('Name','comparacion step C y D')
        step(sys,sysd)
        title("step continua y distreta")
        grid on
%%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
    B =figure('Name','comparacion bode C y D')
        bodemag(sys,sysd)
        title("bode continua y discreta")
        grid on
end

