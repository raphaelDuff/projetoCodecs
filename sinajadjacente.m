fo=602;
frequenciasAdj=[fo]
fs=1204;

%signalA=sin(2*pi*fo*frequenciasAmostragem);
N = 2048;
A=zeros(1,length(N));
frequenciasAmostragem = linspace(0,fs,N);
ts = 1./frequenciasAmostragem;
somatorioSenos=[sin(fo*frequenciasAmostragem)];
A=[];
for fo=602:0.5:608       
    %frequenciasAdj=[frequenciasAdj,fo];
    A=[A,fft(sin(2*pi*fo*ts),N)];
end


plot(frequenciasAmostragem,abs(A))


% for aux=1:size(somatorioSenos)
%     A=[A,fft(somatorioSenos(aux))]
% end
% 
% plot(frequenciasAmostragem,abs(A))