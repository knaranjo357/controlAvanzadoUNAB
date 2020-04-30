function [A,B]= graficas_step_u_puntoEquilibrio (sys_new, sys_u, xini)
figure(1)
A=initial(sys_new,xini)
grid

figure(2)
B=initial(sys_u,xini)
grid
end
