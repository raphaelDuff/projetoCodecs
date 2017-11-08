function [Xk,w,f] = Func_Canal(fo,fs,Nperiodos,Tmax,t)

N2 = 300;
Xk=zeros(1,length(N2));
for fo=602:0.5:608
    %vetor x(t)= cos(2*pi*fo*t)
    xt = cos(2*pi*fo*t);
    %espectro do sinal x(t) -> X(k) == Transformada FFT da função xt
    Xk =Xk + fft(xt,N2);
end


% N a quantidade de amostras do vetor xt
%N = length(xt);
%vetor k
k = [0:N2 - 1];
%vetor w
w = k*(2*pi)./N2;
%vetor f
f = w.*(fs/2*pi);

%graficos
subplot(4,1,1), stem(t,xt, 'filled')
        title ('x(t)')
        xlabel ('Amostras no tempo')
        ylabel ('Amplitude')
hold on

subplot(4,1,2), stem(k,abs(Xk), 'filled')
        title ('X(k)')
        xlabel ('Frequencia ')
        ylabel ('Amplitude')
hold on

subplot(4,1,3), stem(w,abs(Xk), 'filled')
        title ('X(w)')
        xlabel ('Frequencia ')
        ylabel ('Amplitude')
hold on

subplot(4,1,4), stem(f,abs(Xk), 'filled')
        title ('X(f)')
        xlabel ('Frequencia ')
        ylabel ('Amplitude')
hold on
%         stem(f(1:(N2/2)+ 1), abs(Xk(1:(N2/2)+ 1)) ,'r', 'filled')
end