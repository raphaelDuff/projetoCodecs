function [TX_tPbPrDC,TX_tPbPrAC,TX_tYdc,TX_tYac]=convHuffMat(tPbPrDC, tPbPrAC, tYdc, tYac, i)
% Essa funcao tem como entrada as tabelas huff, e gera a serializacao de
% cada categoria de cada tabela.

TX_tPbPrDC=tPbPrDC(i);
TX_tPbPrDC=cell2mat(TX_tPbPrDC);

TX_tPbPrAC=tPbPrAC(i);
TX_tPbPrAC=cell2mat(TX_tPbPrAC);

TX_tYdc=tYdc(i);
TX_tYdc=cell2mat(TX_tYdc);

TX_tYac=tYac(i);
TX_tYac=cell2mat(TX_tYac);

end