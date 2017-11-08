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

for img = 1:10 %Verifica do quadro 1 até o quadro final (NumberOfFrames) loop
    
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

    
    %%%%%%% BLOCO RUIDO INICIO %%%%%%%%      
    L = 5000; %Número max de amostras do ruido
    mu = 0; %NAO SABEMOS (INVESTIGAR)
    sigma = 0; %Offset do ruido (Desloca o ruido)
    Ruido = Func_ruido(L,mu,sigma);
    %%%%%%% BLOCO RUIDO FIM %%%%%%%%      
   
    
    
    
    %%%%%%% RESTO EM ANDAMENTO %%%%%%%%
%     [tYdc, tYac, tPbPrDC, tPbPrAC]=statistics(x_Concat_Y, x_Concat_Y, x_Concat_Y);
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
% Y2 = 0.587*G2+0.299*R2+0.114*B2;
% Pb2 = 0.564*(B2-Y2);
% Pr2 = 0.713*(R2-Y2);
% 
% I(:,:,1)=R2;
% I(:,:,2)=G2;
% I(:,:,3)=B2;
% 
% nome_arquivo=strcat('frameComp',num2str(img),'.jpg'); %Concatena a palavra "frame" + sequencia numerica a partir de 1 e cria o arquivo .jpg
% imwrite(uint8(I),nome_arquivo);   %Cria os arquivos jpg (COMPRIMIDO)
% images{img} = imread(nome_arquivo); % Cria matriz a partir das imagens comprimidas .jpg
% end
% 
% % Cria um arquivo de video com a taxa de frame definida: 30fps
% finalVideo = VideoWriter('Happy_Feet_COMPRIMIDO.avi');
% finalVideo.FrameRate = 30;  %FPS
% 
% % Abre o arquivo para gravação
% open(finalVideo);
% % Grava os frames (definidos por images) no video
% for u=1:length(images)
%     % Converte imagem em frame
%     frame = im2frame(images{u});
%     writeVideo(finalVideo, frame);
% end
% 
% % Fecha o arquivo final
% close(finalVideo);



