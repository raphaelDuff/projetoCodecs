function choiceTraceDepth = dialogChooseDepth
    prompt={'Entre com um valor para a traceDepth (p/ Tx1=1/2 - traceDepth=98 '};
    name='Profundidade de regressão do código de canal';
    defaultans={'98'};
    options.Interpreter = 'tex';
    answer = inputdlg(prompt,name,[1 40],defaultans,options);
    end
    
%    conta = rem(traceDepth,txY)
%     if (x ~= 0)
%         traceDepth = traceDepth + (txY - x)