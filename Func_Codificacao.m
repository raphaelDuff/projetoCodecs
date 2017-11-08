function [Yq, Pbq, Prq, V, H] = Func_Codificacao(R,G,B,S,v,frame)

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

%Realizando DCT das 3 matrizes Y Pb Pr
T = dctmtx(8);
dct_Y =  @(block_struct) round ((T*block_struct.data*T')./Q1);
dct_PbPr = @(block_struct) round ((T*block_struct.data*T')./Q2);
V=size(R,1);
H=size(R,2);

    Y = 0.587*G+0.299*R+0.114*B;
    Yq = blockproc(Y, [8 8], dct_Y);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
	   
    Pb = 0.564*(B-Y);
    Pbq = blockproc(Pb, [8 8], dct_PbPr);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
    Pr = 0.713*(R-Y);
    Prq = blockproc(Pr, [8 8], dct_PbPr);
    %remover (:,:,frame) quando criar a função DCT, pois faremos para cada
    %frame no MAIN CODE
    frame = frame+1;
end