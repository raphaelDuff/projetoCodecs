function [ruido]=Func_ruido(L,mu,sigma)

ruido = sigma + randn(L,1) + mu;

figure (1)
plot(ruido)
title('White noise');
xlabel('Samples')
ylabel('Sample Values')
grid on;

end