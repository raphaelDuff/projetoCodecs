function[txY, txPbPr]=statistics(concY, concPb, concPr)
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

txY = func_TX(Yac,Ydc,YacCat,YdcCat,tYac,tYdc);
txY=txY';
txPbPr = func_TX(PbPrAC,PbPrDC,PbPrACCat,PbPrDCCat,tPbPrAC,tPbPrDC);
txPbPr=txPbPr';

% txYac = func_TX(Yac,tYac,YacCat);
% txYdc = func_TX(Ydc,tYdc,YdcCat);

% txPbPrAC=[huffmanenco(PbPrACCat(i),tPbPrAC);n];
% txYac=[huffmanenco(YacCat(i),tYdc);n];
% txYdc=[huffmanenco(YdcCat(i),tYac);n];
end