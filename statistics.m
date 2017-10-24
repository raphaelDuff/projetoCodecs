function[txYdc, txYac,txPbPrDC, txPbPrAC]=statistics(concY, concPb, concPr)
%%  Ajusta tamanho dos vetores
concPbPr=[concPb concPr];
PbPrDC=zeros(1,length(concPbPr)/64);
PbPrAC=zeros(1,length(concPbPr)-length(PbPrDC));
Ydc=zeros(1,length(concY)/64);
Yac=zeros(1,length(concY)-length(Ydc));

j=1;
h=1;

%%  Cria vetores Ydc e Yac
for i=1:length(concY)
    if i==1 || rem((i-1),64)==0
        Ydc(h)=concY(i);
        h=h+1;
    else
        Yac(j)=concY(i);
        j=j+1;
    end
end

j=1;
h=1;

%%  Cria vetores PbPrDC e PbPrAC
for i=1:length(concPbPr)
    if i==1 || rem((i-1),64)==0
        PbPrDC(h)=concPbPr(i);
        h=h+1;
    else
        PbPrAC(j)=concPbPr(i);
        j=j+1;
    end
end

%%  Transforma vetores em vetores de categorias (0 a 7)
[PbPrDCCat]=categoria(PbPrDC);
[PbPrACCat]=categoria(PbPrAC);
[YacCat]=categoria(Yac);
[YdcCat]=categoria(Ydc);

%%  Extrai a probabilidade dos vetores de categoria
M=histogram(PbPrDCCat,9,'Normalization','probability','BinWidth',1,'BinLimits',[0 9]);
PbPrDCProb=M.Values;
N=histogram(PbPrACCat,9,'Normalization','probability','BinWidth',1,'BinLimits',[0 9]);
PbPrACProb=N.Values;
O=histogram(YdcCat,9,'Normalization','probability','BinWidth',1,'BinLimits',[0 9]);
YdcProb=O.Values;
P=histogram(YacCat,9,'Normalization','probability','BinWidth',1,'BinLimits',[0 9]);
YacProb=P.Values;

%%  Define range das categorias (0 até 8)
catRange=[0:8];

%%  Extrai tabela huffman para cada vetor
[tPbPrDC]=huffman(PbPrDCProb, catRange);
[tPbPrAC]=huffman(PbPrACProb, catRange);
[tYdc]=huffman(YdcProb, catRange);
[tYac]=huffman(YacProb, catRange);

%%  TX Categoria 0
[TX0_tPbPrDC,TX0_tPbPrAC,TX0_tYdc,TX0_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 9);

%%  TX Categoria 1
[TX1_tPbPrDC,TX1_tPbPrAC,TX1_tYdc,TX1_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 10);

%%  TX Categoria 2
[TX2_tPbPrDC,TX2_tPbPrAC,TX2_tYdc,TX2_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 11);

%%  TX Categoria 3
[TX3_tPbPrDC,TX3_tPbPrAC,TX3_tYdc,TX3_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 12);

%%  TX Categoria 4
[TX4_tPbPrDC,TX4_tPbPrAC,TX4_tYdc,TX4_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 13);

%%  TX Categoria 5
[TX5_tPbPrDC,TX5_tPbPrAC,TX5_tYdc,TX5_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 14);

%%  TX Categoria 6
[TX6_tPbPrDC,TX6_tPbPrAC,TX6_tYdc,TX6_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 15);

%%  TX Categoria 7
[TX7_tPbPrDC,TX7_tPbPrAC,TX7_tYdc,TX7_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 16);

%%  TX Categoria 8
[TX8_tPbPrDC,TX8_tPbPrAC,TX8_tYdc,TX8_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, 17);

[txYdc, txPbPrDC, txYac, txPbPrAC]=serialTX(PbPrDCCat, PbPrACCat, YacCat, YdcCat,TX0_tPbPrDC,TX0_tPbPrAC,TX0_tYdc,TX0_tYac,TX1_tPbPrDC,TX1_tPbPrAC,TX1_tYdc,TX1_tYac,TX2_tPbPrDC,TX2_tPbPrAC,TX2_tYdc,TX2_tYac,TX3_tPbPrDC,TX3_tPbPrAC,TX3_tYdc,TX3_tYac,TX4_tPbPrDC,TX4_tPbPrAC,TX4_tYdc,TX4_tYac,TX5_tPbPrDC,TX5_tPbPrAC,TX5_tYdc,TX5_tYac,TX6_tPbPrDC,TX6_tPbPrAC,TX6_tYdc,TX6_tYac,TX7_tPbPrDC,TX7_tPbPrAC,TX7_tYdc,TX7_tYac,TX8_tPbPrDC,TX8_tPbPrAC,TX8_tYdc,TX8_tYac);

end