function images = Destino(R2,G2,B2,frameNumber,images)
I(:,:,1)=R2;
I(:,:,2)=G2;
I(:,:,3)=B2;

nome_arquivo=strcat('frameComp',num2str(frameNumber),'.jpg'); %Concatena a palavra "frame" + sequencia numerica a partir de 1 e cria o arquivo .jpg
imwrite(uint8(I),nome_arquivo);   %Cria os arquivos jpg (COMPRIMIDO)
images{frameNumber} = imread(nome_arquivo); % Cria matriz a partir das imagens comprimidas .jpg

end