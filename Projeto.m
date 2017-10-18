clear all
close all
clc

S=4;

Q1=[16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];

Q2=[17 18 24 47 99 99 99 99;
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99
    ];

video = VideoReader('Happy_Feet.avi');
get(video) %Coleta as informações do video
playvideo=read(video); %Verifica a quantidade de quadros do video
x=size(playvideo);
NumberOfFrames=x(1,4);

% images = cell(NumberOfFrames,1); % Cria matriz para receber todas as imagens após DCT

for img = 1:5; %Verifica do quadro 1 até o quadro final (NumberOfFrames) loop
    
    x = read(video, img);
    %
    %     image(uint8(x))
    % 	str = strcat({'Frame '}, num2str(img),' Original');
    % 	title(str);
    
    if img<NumberOfFrames
        
    end
    %imwrite(x,nome_arquivo);   %Cria os arquivos jpg
    
    X = double(x);
    R=X(:,:,1);
    G=X(:,:,2);
    B=X(:,:,3);
    
    %Transformar a imagem frame1.jpg em matriz Y, PB, PR
    Y = 0.587*G+0.299*R+0.114*B;
    Pb = 0.564*(B-Y);
    Pr = 0.713*(R-Y);
    
    map = colormap(gray(256));
    colormap(map)
    V=size(X,1);
    H=size(X,2);
    
    %Cria matrizes de zeros com o tamanho da variavel x
    x_Concat_Y = zeros(size(x));
    x_Concat_Pb = zeros(size(x));
    x_Concat_Pr = zeros(size(x));
    
    %Deixamos as matrizes como null
            x_Concat_Y=[];
            x_Concat_Pb=[];
            x_Concat_Pr=[];
            
    for i= 1:8:V
        for j=1:8:H
            ydct(i:1:i+7,j:1:j+7)=dct(dct(Y(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
            yq(i:1:i+7,j:1:j+7)=round(ydct(i:1:i+7,j:1:j+7)./(Q1*S)); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
            Pbdct(i:1:i+7,j:1:j+7)=dct(dct(Pb(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
            Pbq(i:1:i+7,j:1:j+7)=round(Pbdct(i:1:i+7,j:1:j+7)./(Q2*S)); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
            Prdct(i:1:i+7,j:1:j+7)=dct(dct(Pr(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
            Prq(i:1:i+7,j:1:j+7)=round(Prdct(i:1:i+7,j:1:j+7)./(Q2*S)); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
    
            %Executamos a função ZIG ZAG para Y,Pb,Pr
            ZIG_ZAG_Y=zigzag(yq(i:1:i+7,j:1:j+7));
            ZIG_ZAG_Pb=zigzag(Pbq(i:1:i+7,j:1:j+7));
            ZIG_ZAG_Pr=zigzag(Prq(i:1:i+7,j:1:j+7));
            
            %Concatenamos Y,Pb,Pr para cada frame
            x_Concat_Y = [x_Concat_Y ZIG_ZAG_Y];
            x_Concat_Pb = [x_Concat_Pb ZIG_ZAG_Pb];
            x_Concat_Pr = [x_Concat_Pr ZIG_ZAG_Pr];
        end
    end
    
    %Recuperamos as informaçoes totais de Y,Pb,Pr
    x_Concat_Y_final(:,:,img) = x_Concat_Y;
    x_Concat_Pb_final(:,:,img) = x_Concat_Pb;
    x_Concat_Pr_final(:,:,img) = x_Concat_Pr;
    %i e j variando com passo 8 apontam sempre para o ponto da esquerda
    %%superior de um novo bloco a ser analisado.
    for i= 1:8:V
        for j=1:8:H
            yqinv(i:1:i+7,j:1:j+7)=yq(i:1:i+7,j:1:j+7).*(Q1*S); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
            yfinal(i:1:i+7,j:1:j+7)=idct(idct(yqinv(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
            Pbqinv(i:1:i+7,j:1:j+7)=Pbq(i:1:i+7,j:1:j+7).*(Q2*S); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
            Pbfinal(i:1:i+7,j:1:j+7)=idct(idct(Pbqinv(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
            Prqinv(i:1:i+7,j:1:j+7)=Prq(i:1:i+7,j:1:j+7).*(Q2*S); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
            Prfinal(i:1:i+7,j:1:j+7)=idct(idct(Prqinv(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
        
        INV_ZIG_ZAG_Y=func_ZIG_ZAG_INV(ZIG_ZAG_Y,8,8);
        INV_ZIG_ZAG_Pb=func_ZIG_ZAG_INV(ZIG_ZAG_Pb,8,8);
        INV_ZIG_ZAG_Pr=func_ZIG_ZAG_INV(ZIG_ZAG_Pr,8,8);
        
        for k=1:65:length(x_Concat_Y_final)
            Yziginv(i:1:i+7,j:1:j+7) = INV_ZIG_ZAG_Y;
            Pbziginv(i:1:i+7,j:1:j+7) = INV_ZIG_ZAG_Pb;
            Prziginv(i:1:i+7,j:1:j+7) = INV_ZIG_ZAG_Pr;
        end
        
        end
    end
    
    B2=(Pbfinal/0.564)+yfinal;
    R2=(Prfinal/0.713)+yfinal;
    G2=(yfinal-0.299*R2-0.114*B2)/0.587;
    
    Y2 = 0.587*G2+0.299*R2+0.114*B2;
    Pb2 = 0.564*(B2-Y2);
    Pr2 = 0.713*(R2-Y2);
    
    I(:,:,1)=R2;
    I(:,:,2)=G2;
    I(:,:,3)=B2;
    
    nome_arquivo=strcat('frameComp',num2str(img),'.jpg'); %Concatena a palavra "frame" + sequencia numerica a partir de 1 e cria o arquivo .jpg
    imwrite(uint8(I),nome_arquivo);   %Cria os arquivos jpg (COMPRIMIDO)
    images{img} = imread(nome_arquivo); % Cria matriz a partir das imagens comprimidas .jpg
end

% Cria um arquivo de video com a taxa de frame definida: 30fps
finalVideo = VideoWriter('Happy_Feet_COMPRIMIDO.avi');
finalVideo.FrameRate = 30;  %FPS

% Abre o arquivo para gravação
open(finalVideo);
% Grava os frames (definidos por images) no video
for u=1:length(images)
    % Converte imagem em frame
    frame = im2frame(images{u});
    writeVideo(finalVideo, frame);
end

% Fecha o arquivo final
close(finalVideo);



