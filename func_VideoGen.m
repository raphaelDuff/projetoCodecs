function VideoGen(images)

% Cria um arquivo de video com a taxa de frame definida: 30fps
finalVideo = VideoWriter('Happy_Feet_COMPRIMIDO.avi');
finalVideo.FrameRate = 30;  %FPS
open(finalVideo);
% Grava os frames (definidos por images) no video
% Converte imagem em frame
for u=1:length(images)
     % Converte imagem em frame
    frame = im2frame(images{u});
    writeVideo(finalVideo, frame);
end

% Fecha o arquivo final
close(finalVideo);
end