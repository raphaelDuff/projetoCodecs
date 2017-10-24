function [txYdc, txPbPrDC, txYac, txPbPrAC]=serialTX(PbPrDCCat, PbPrACCat, YacCat, YdcCat,TX0_tPbPrDC,TX0_tPbPrAC,TX0_tYdc,TX0_tYac,TX1_tPbPrDC,TX1_tPbPrAC,TX1_tYdc,TX1_tYac,TX2_tPbPrDC,TX2_tPbPrAC,TX2_tYdc,TX2_tYac,TX3_tPbPrDC,TX3_tPbPrAC,TX3_tYdc,TX3_tYac,TX4_tPbPrDC,TX4_tPbPrAC,TX4_tYdc,TX4_tYac,TX5_tPbPrDC,TX5_tPbPrAC,TX5_tYdc,TX5_tYac,TX6_tPbPrDC,TX6_tPbPrAC,TX6_tYdc,TX6_tYac,TX7_tPbPrDC,TX7_tPbPrAC,TX7_tYdc,TX7_tYac,TX8_tPbPrDC,TX8_tPbPrAC,TX8_tYdc,TX8_tYac)
% Essa funcao tem como entrada as tabelas huff, e gera a serializacao de
% cada categoria de cada tabela.
txPbPrDC=[];
txPbPrAC=[];
txYac=[];
txYdc=[];
for i=1:length(PbPrDCCat)
    
    if PbPrDCCat(i)==0
        txPbPrDC=[txPbPrDC TX0_tPbPrDC];
        
    elseif PbPrDCCat(i)==1
        txPbPrDC=[txPbPrDC TX1_tPbPrDC];
        
    elseif PbPrDCCat(i)==2
        txPbPrDC=[txPbPrDC TX2_tPbPrDC];
        
    elseif PbPrDCCat(i)==3
        txPbPrDC=[txPbPrDC TX3_tPbPrDC];
        
    elseif PbPrDCCat(i)==4
        txPbPrDC=[txPbPrDC TX4_tPbPrDC];
        
    elseif PbPrDCCat(i)==5
        txPbPrDC=[txPbPrDC TX5_tPbPrDC];
        
    elseif PbPrDCCat(i)==6
        txPbPrDC=[txPbPrDC TX6_tPbPrDC];
        
    elseif PbPrDCCat(i)==7
        txPbPrDC=[txPbPrDC TX7_tPbPrDC];
        
    elseif PbPrDCCat(i)==8
        txPbPrDC=[txPbPrDC TX8_tPbPrDC];
    end
end
for i=1:length(PbPrACCat)
    if PbPrACCat(i)==0
        txPbPrAC=[txPbPrAC TX0_tPbPrAC];
        
    elseif PbPrACCat(i)==1
        txPbPrAC=[txPbPrAC TX1_tPbPrAC];
        
    elseif PbPrACCat(i)==2
        txPbPrAC=[txPbPrAC TX2_tPbPrAC];
        
    elseif PbPrACCat(i)==3
        txPbPrAC=[txPbPrAC TX3_tPbPrAC];
        
    elseif PbPrACCat(i)==4
        txPbPrAC=[txPbPrAC TX4_tPbPrAC];
        
    elseif PbPrACCat(i)==5
        txPbPrAC=[txPbPrAC TX5_tPbPrAC];
        
    elseif PbPrACCat(i)==6
        txPbPrAC=[txPbPrAC TX6_tPbPrAC];
        
    elseif PbPrACCat(i)==7
        txPbPrAC=[txPbPrAC TX7_tPbPrAC];
        
    elseif PbPrACCat(i)==8
        txPbPrAC=[txPbPrAC TX8_tPbPrAC];
    end
end
for i=1:length(YacCat)
    if YacCat(i)==0
        txYac=[txYac TX0_tYac];
        
    elseif YacCat(i)==1
        txYac=[txYac TX1_tYac];
        
    elseif YacCat(i)==2
        txYac=[txYac TX2_tYac];
        
    elseif YacCat(i)==3
        txYac=[txYac TX3_tYac];
        
    elseif YacCat(i)==4
        txYac=[txYac TX4_tYac];
        
    elseif YacCat(i)==5
        txYac=[txYac TX5_tYac];
        
    elseif YacCat(i)==6
        txYac=[txYac TX6_tYac];
        
    elseif YacCat(i)==7
        txYac=[txYac TX7_tYac];
        
    elseif YacCat(i)==8
        txYac=[txYac TX8_tYac];
    end
end
for i=1:length(YdcCat)
    if YdcCat(i)==0
        txYdc=[txYdc TX0_tYdc];
        
    elseif YdcCat(i)==1
        txYdc=[txYdc TX1_tYdc];
        
    elseif YdcCat(i)==2
        txYdc=[txYdc TX2_tYdc];
        
    elseif YdcCat(i)==3
        txYdc=[txYdc TX3_tYdc];
        
    elseif YdcCat(i)==4
        txYdc=[txYdc TX4_tYdc];
        
    elseif YdcCat(i)==5
        txYdc=[txYdc TX5_tYdc];
        
    elseif YdcCat(i)==6
        txYdc=[txYdc TX6_tYdc];
        
    elseif YdcCat(i)==7
        txYdc=[txYdc TX7_tYdc];
        
    elseif YdcCat(i)==8
        txYdc=[txYdc TX8_tYdc];
    end
end
end
