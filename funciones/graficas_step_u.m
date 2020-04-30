function [A,B] = graficas_step_u (sysLQR_lc, sys_u)
 %%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
    A =figure('Name','RTA step')
        step(sysLQR_lc)
        title("respuesta step")
        grid on
%%%%%   %%%%%   %%%%%   %%%%%%  %%%%%   %%%%%
    B =figure('Name','RTA U')
        step(sys_u)
        title("accion de control")
        grid on
end