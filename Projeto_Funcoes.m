clear all
close all
clc

S=4;
video = VideoReader('Happy_Feet.avi');
get(video) %Coleta as informações do video
playvideo=read(video); %Verifica a quantidade de quadros do video
x=size(playvideo);
NumberOfFrames=x(1,4);

images = cell(NumberOfFrames,1); % Cria matriz para receber todas as imagens após DCT

for img = 1:NumberOfFrames %Verifica do quadro 1 até o quadro final (NumberOfFrames) loop
    
    [R,G,B] = Fonte(video,img);
    [Yq, Pbq, Prq, V, H] = Codificacao(R,G,B,S);
    [x_Concat_Y, x_Concat_Pb, x_Concat_Pr] = ZigZagRequest(V,H,Yq,Pbq,Prq);
    [tYdc, tYac, tPbPrDC, tPbPrAC]=statistics(x_Concat_Y, x_Concat_Y, x_Concat_Y);
    [R2,G2,B2] = Decodificacao(Yq,Pbq,Prq,S,V,H);
    images = Destino(R2,G2,B2,img,images);
    
    
end

VideoGen(images);
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



