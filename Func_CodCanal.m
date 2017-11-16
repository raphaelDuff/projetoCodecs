function [txY_cod_final,txPbPr_cod_final] = Func_CodCanal(traceDepth,taxa,txY,txPbPr)

convEncoder = comm.ConvolutionalEncoder(poly2trellis(7, [171 133]));
convEncoder.PuncturePatternSource = 'Property';
convEncoder.PuncturePattern = taxa;
txY_cod_atraso = zeros(traceDepth,1);
txY_cod = [txY';txY_cod_atraso];
txY_cod_final = step(convEncoder,txY_cod);

convEncoder = comm.ConvolutionalEncoder(poly2trellis(7, [171 133]));
convEncoder.PuncturePatternSource = 'Property';
convEncoder.PuncturePattern = taxa;
txPbPr_cod_atraso = zeros(93,1);
txPbPr_cod = [txPbPr';txPbPr_cod_atraso];
txPbPr_cod_final = step(convEncoder,txPbPr_cod);

end