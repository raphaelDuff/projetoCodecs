clear all
close all
clc

S=4;
video = VideoReader('Happy_Feet.avi');
get(video) %Coleta as informações do video
playvideo=read(video); %Verifica a quantidade de quadros do video
x=size(playvideo);
NumberOfFrames=x(1,4);
v = VideoReader('Happy_Feet.avi');

frame = 1;

images = cell(NumberOfFrames,1); % Cria matriz para receber todas as imagens após DCT
%%% Bloco para chamar o dialogbox para escolha da taxa de codificação do
%%% canal
taxaCodificacao = dialogChooseTaxa; 
    switch taxaCodificacao
        case('1/2')
            taxaCodificacao = [1;1];
        case('2/3')
            taxaCodificacao = [1;1;0;1];
  
        case('3/4')
            taxaCodificacao = [1;1;0;1;1;0];
        case('5/6')
            taxaCodificacao = [1;1;0;1;1;0;0;1;1;0];
        case('7/8')
            taxaCodificacao = [1;1;0;1;0;1;0;1;1;0;0;1;1;0];
    end
    
    %%%%%%% FIM DO BLOCO PARA ESCOLHA DA TAXA DE CODIFICAÇÃO %%%%%%%%
    
for img = 1:5 %Verifica do quadro 1 até o quadro final (NumberOfFrames) loop
    
    %%%%%%% BLOCO FONTE INICIO %%%%%%%%
    [R,G,B] = Func_Fonte(video,img);
    %%%%%%% BLOCO FONTE FIM %%%%%%%%%       testado OK
    
    %%%%%%% BLOCO CODIFICAÇÃO INICIO %%%%%%%%
    [Yq, Pbq, Prq, V, H] = Func_Codificacao(R,G,B,S,v,frame);
    %%%%%%% BLOCO CODIFICAÇÃO FIM %%%%%%%%       TESTADO OK
    
    %%%%%%% BLOCO ZIGZAG INICIO %%%%%%%%
    out='[';
    for z=1:63
        out = [out,'A(i(',int2str(z),'),j(',int2str(z),')),'];
    end
    out = [out,'A(i(',int2str(z+1),'),j(',int2str(z+1),'))]'];
    
    Yq_Concat = @(block_struct) Func_ZigZag(block_struct.data,out);
    Yq_Concat_Intermed = blockproc(Yq, [8 8], Yq_Concat);
    Yq_Concat_FINAL = reshape(Yq_Concat_Intermed,1,prod(size(Yq_Concat_Intermed)));
    
    Pbq_Concat = @(block_struct) Func_ZigZag(block_struct.data,out);
    Pbq_Concat_Intermed = blockproc(Pbq, [8 8], Pbq_Concat);
    Pbq_Concat_FINAL = reshape(Pbq_Concat_Intermed,1,prod(size(Pbq_Concat_Intermed)));
    
    Prq_Concat = @(block_struct) Func_ZigZag(block_struct.data,out);
    Prq_Concat_Intermed = blockproc(Prq, [8 8], Prq_Concat);
    Prq_Concat_FINAL = reshape(Prq_Concat_Intermed,1,prod(size(Prq_Concat_Intermed)));
    %%%%%%% BLOCO ZIGZAG FIM %%%%%%%%
    
    %%%%%%% BLOCO HUFFMAN INICIO (TX) %%%%%%%%
    
    [txY, txPbPr]=statistics(Yq_Concat_FINAL, Pbq_Concat_FINAL, Prq_Concat_FINAL);
    
    % traceDepth = input(prompt);
    
    taxaCodificacao = dialogChooseTaxa;
    
    
    %%%%%%% BLOCO HUFFMAN FIM (TX) %%%%%%%%
    
   
    %%%%%%% TAXA REGRESSAO CODIGO CANAL - (traceDepth) %%%%%%%%
    
    %%%%%%% BLOCO RUIDO INICIO %%%%%%%%
    L = 5000; %Número max de amostras do ruido
    mu = 0; %NAO SABEMOS (INVESTIGAR)
    sigma = 0; %Offset do ruido (Desloca o ruido)
    Ruido = Func_ruido(L,mu,sigma);
    %%%%%%% BLOCO RUIDO FIM %%%%%%%%
    
      
    %%%%%%% BLOCO CANAL ADJACENTE INICIO %%%%%%%%
    % frequencia do sinal (Hz)
    fo = 602;
    %frequencia de amostragem (Hz)
    fs = 4000;
    %numero de periodos
    Nperiodos = 2;
    %quantidade de periodos do sinal discreto no tempo TMax
    Tmax = (Nperiodos/fo) - (1/fs);
    %vetor de tempo t
    t = [0:(1/fs):Tmax];
    
    
    CANAL = Func_Canal(fo,fs,Nperiodos,Tmax,t);
    
    %%%%%%% BLOCO CANAL ADJACENTE FIM %%%%%%%%
    
    
    
    %%%%%%% BLOCO TEORIA INICIO %%%%%%%%
    
    msglen = 10000; %tamanho da mensagem
    Func_ASK_FSK_PSK(msglen);
    
    %%%%%%% BLOCO TEORIA INICIO %%%%%%%%
    
    %%%%%%% TAXA REGRESSAO CODIGO CANAL - (traceDepth) INICIO %%%%%%%%

    traceDepth = dialogChooseDepth; %chama a DialogBox
    traceDepth = str2num(traceDepth);
    
    %%%%%%% TAXA REGRESSAO CODIGO CANAL - (traceDepth) FIM %%%%%%%%

    
    
    
    %%%%%%% BLOCO CODIFICADOR DE CANAL INICIO %%%%%%%%
               
      
    [txY_cod_final,txPbPr_cod_final] = Func_CodCanal(traceDepth,taxaCodificacao,txY,txPbPr);
    
    
    %%%%%%% BLOCO CODIFICADOR DE CANAL FIM %%%%%%%%
    
    
    
    %%%%%%% BLOCO DECODIFICADOR DE CANAL INICIO %%%%%%%%
    
    [txY_dec_final,txPbPr_dec_final] = Func_DecodCanal(taxaCodificacao,txY_cod_final,txPbPr_cod_final); 
    
    %%%%%%% BLOCO DECODIFICADOR DE CANAL FIM %%%%%%%%
    
    
    
    
    
    
    
    
    
    
    
    %%%%%%% RESTO EM ANDAMENTO %%%%%%%%
    %     [R2,G2,B2] = Decodificacao(Yq,Pbq,Prq,S,V,H);
    %     images = Destino(R2,G2,B2,img,images);
    
    
end

%VideoGen(images);
% %Recuperamos as informaçoes totais de Y,Pb,Pr
% x_Concat_Y_final(:,:,img) = x_Concat_Y;
% x_Concat_Pb_final(:,:,img) = x_Concat_Pb;
% x_Concat_Pr_final(:,:,img) = x_Concat_Pr;
%i e j variando com passo 8 apontam sempre para o ponto da esquerda
%%superior de um novo bloco a ser analisado.
% for i= 1:8:V
%     for j=1:8:H
%
%         INV_ZIG_ZAG_Y=func_ZIG_ZAG_INV(ZIG_ZAG_Y,8,8);
%         INV_ZIG_ZAG_Pb=func_ZIG_ZAG_INV(ZIG_ZAG_Pb,8,8);
%         INV_ZIG_ZAG_Pr=func_ZIG_ZAG_INV(ZIG_ZAG_Pr,8,8);
%
%         for k=1:65:length(x_Concat_Y_final)
%             Yziginv(i:1:i+7,j:1:j+7) = INV_ZIG_ZAG_Y;
%             Pbziginv(i:1:i+7,j:1:j+7) = INV_ZIG_ZAG_Pb;
%             Prziginv(i:1:i+7,j:1:j+7) = INV_ZIG_ZAG_Pr;
%         end
%
%     end
% end
%
%
%