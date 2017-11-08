function [txY_dec_final,txPbPr_dec_final] = Func_DecodCanal(Tx1,txY_cod_final,txPbPr_cod_final)

vitDecoder = comm.ViterbiDecoder(poly2trellis(7, [171 133]));
vitDecoder.PuncturePatternSource =  'Property';
convEncoder.PuncturePattern = Tx1;
vitDecoder.PuncturePattern = convEncoder.PuncturePattern;
vitDecoder.TracebackDepth = 98;
vitDecoder.InputFormat = 'Hard';
txY_dec = step(vitDecoder,txY_cod_final);
txY_dec_final = txY_dec(99:end);


vitDecoder = comm.ViterbiDecoder(poly2trellis(7, [171 133]));
vitDecoder.PuncturePatternSource =  'Property';
convEncoder.PuncturePattern = Tx1;
vitDecoder.PuncturePattern = convEncoder.PuncturePattern;
vitDecoder.TracebackDepth = 93;
vitDecoder.InputFormat = 'Hard';
txPbPr_dec = step(vitDecoder,txPbPr_cod_final);
txPbPr_dec_final = txPbPr_dec(94:end);

end