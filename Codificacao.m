function [Yq, Pbq, Prq, V, H] = Codificacao(R,G,B,S)


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

Y = 0.587*G+0.299*R+0.114*B;
Pb = 0.564*(B-Y);
Pr = 0.713*(R-Y);

V=size(R,1);
H=size(R,2);

for i= 1:8:V
    for j=1:8:H
        ydct(i:1:i+7,j:1:j+7)=dct(dct(Y(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
        Yq(i:1:i+7,j:1:j+7)=round(ydct(i:1:i+7,j:1:j+7)./(Q1*S)); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
        Pbdct(i:1:i+7,j:1:j+7)=dct(dct(Pb(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
        Pbq(i:1:i+7,j:1:j+7)=round(Pbdct(i:1:i+7,j:1:j+7)./(Q2*S)); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
        Prdct(i:1:i+7,j:1:j+7)=dct(dct(Pr(i:1:i+7,j:1:j+7))')'; %cada bloco de 8x8 da matriz xdct recebe a DCT de um bloco 8x8 da matriz X
        Prq(i:1:i+7,j:1:j+7)=round(Prdct(i:1:i+7,j:1:j+7)./(Q2*S)); %cada bloco de 8x8 da matriz xq recebe o resultado da quantização de um bloco 8x8 da matriz xdct
    end
end
end