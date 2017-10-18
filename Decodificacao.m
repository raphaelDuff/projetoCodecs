function [R2,G2,B2] = Decodificacao(Yq,Pbq,Prq,S,V,H)
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

for i= 1:8:V
    for j=1:8:H
        yqinv(i:1:i+7,j:1:j+7)=Yq(i:1:i+7,j:1:j+7).*(Q1*S); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
        yfinal(i:1:i+7,j:1:j+7)=idct(idct(yqinv(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
        Pbqinv(i:1:i+7,j:1:j+7)=Pbq(i:1:i+7,j:1:j+7).*(Q2*S); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
        Pbfinal(i:1:i+7,j:1:j+7)=idct(idct(Pbqinv(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
        Prqinv(i:1:i+7,j:1:j+7)=Prq(i:1:i+7,j:1:j+7).*(Q2*S); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
        Prfinal(i:1:i+7,j:1:j+7)=idct(idct(Prqinv(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
    end
end

B2=(Pbfinal/0.564)+yfinal;
R2=(Prfinal/0.713)+yfinal;
G2=(yfinal-0.299*R2-0.114*B2)/0.587;

end