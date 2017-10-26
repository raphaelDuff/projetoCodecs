% Probabilidades de erros com filtro
% probErroASK=Q*sqrt(EP/(2*N));
% probErroPSK=Q*sqrt((2*EP)/N);
% probErroFSK=Q*sqrt((1.217*EP)/N);
% probErroASK4=((3/2)*Q)*sqrt(EP/N);

% t=[1:100]
% w= t/(  2*pi)
% signalAdj1=sin(2*pi*602*MEGA*t)
% x=fft(signalAdj1)
% plot(x,100)


clc
clear all
close all
MEGA=1000000
fo=602*MEGA


%fo=100;
fs=8000;
Np=3;
Tmax=(Np/fo)-(1/fs);
t=[0:(1/fs):Tmax];
xt=cos(2*pi*fo*t);
X=fft(xt);
N=size(xt);
k=0:N(2)-1;
w=2*pi*k./N(2);
f=w.*fs/(2*pi);

subplot(4,1,1), stem(t,xt)
    title ('x(t)')
    xlabel ('Amostras no tempo')
    ylabel ('Amplitude')

subplot(4,1,2), stem(k,abs(X))
    title ('X(k)')
    xlabel ('Amostras no tempo')
    ylabel ('Amplitude')
    
subplot(4,1,3), stem(w,abs(X))
    title ('X(w)')
    xlabel ('Amostras no tempo')
    ylabel ('Amplitude')
subplot(4,1,4), stem(f,abs(X))
    title ('X(f)')
    xlabel ('Amostras no tempo')
    ylabel ('Amplitude')
hold on
% X1=X(1:((N(2)/2)+1));
% f1=f(1:((N(2)/2)+1));
% subplot(4,1,4), stem(f1,abs(X1))
%     title ('X(1:((N/2)+1)) por f(1:((N/2)+1) ')
%     xlabel ('Amostras no tempo')
%     ylabel ('Amplitude')