clear all
close all
clc


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

v = VideoReader('Happy_Feet.avi');

frame = 1;

%Realizando DCT das 3 matrizes Y Pb Pr
T = dctmtx(8);
dct_Y =  @(block_struct) round ((T*block_struct.data*T')./Q1);
dct_PbPr = @(block_struct) round ((T*block_struct.data*T')./Q2);

while hasFrame(v)
    video = readFrame(v);
    X = double(video);
    Y = 0.587*X(:,:,2)+0.299*X(:,:,1)+0.114*X(:,:,3);
    Y_dct_q(:,:,frame) = blockproc(Y, [8 8], dct_Y);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
	   
    Pb = 0.564*(X(:,:,2)-Y);
    Pb_dct_q(:,:,frame) = blockproc(Pb, [8 8], dct_PbPr);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
    Pr = 0.713*(X(:,:,3)-Y);
    Pr_dct_q(:,:,frame) = blockproc(Pr, [8 8], dct_PbPr);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
    frame = frame+1;
end




% %Realizando IDCT das 3 matrizes Y Pb Pr
% dct_inv_Y =  @(block_struct) ((T'*block_struct.data*T).*Q1);
% dct_inv_PbPr = @(block_struct) ((T'*block_struct.data*T).*Q2);
% frame_inv = 1;
% for i = 1:frame
%     Y_idct_q(:,:,frame_inv) = blockproc(Y_dct_q(:,:,frame_inv), [8 8], dct_inv_Y);
% 	    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
%     %frame no MAIN CODE
%     Pb_idct_q(:,:,frame_inv) = blockproc(Pb_dct_q(:,:,frame_inv), [8 8], dct_inv_PbPr);
%     %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
%     %frame no MAIN CODE
%     Pr_idct_q(:,:,frame_inv) = blockproc(Pr_dct_q(:,:,frame_inv), [8 8], dct_inv_PbPr);
%     %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
%     %frame no MAIN CODE
%     frame_inv = frame_inv+1;
% end




ZigZag =  @(block_struct) ZigZagscan(block_struct.data);
for frame2 = 1:frame
    
    Y_ZIGZAG(:,:,frame2) = blockproc(Y_dct_q(:,:,frame2), [8 8], ZigZag);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
	   
    Pb_ZIZZAG(:,:,frame2) = blockproc(Pb_dct_q(:,:,frame2), [8 8], ZigZag);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
    
    Pr_ZIGZAG(:,:,frame2) = blockproc(Pr_dct_q(:,:,frame2), [8 8], ZigZag);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
end