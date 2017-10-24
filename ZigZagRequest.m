function [x_Concat_Y, x_Concat_Pb, x_Concat_Pr] = ZigZagRequest(V,H,Yq,Pbq,Prq)
%Cria matrizes de zeros com o tamanho da variavel x
x_Concat_Y = zeros(size(x));
x_Concat_Pb = zeros(size(x));
x_Concat_Pr = zeros(size(x));

%Deixamos as matrizes como null
x_Concat_Y=[];
x_Concat_Pb=[];
x_Concat_Pr=[];

for i=1:8:V
    for j=1:8:H
        %Executamos a função ZIG ZAG para Y,Pb,Pr (Valores já
        %quantizados
        ZIG_ZAG_Y=zigzag(Yq(i:1:i+7,j:1:j+7));
        ZIG_ZAG_Pb=zigzag(Pbq(i:1:i+7,j:1:j+7));
        ZIG_ZAG_Pr=zigzag(Prq(i:1:i+7,j:1:j+7));
        
        %Concatenamos Y,Pb,Pr para cada frame
        x_Concat_Y = [x_Concat_Y ZIG_ZAG_Y];
        x_Concat_Pb = [x_Concat_Pb ZIG_ZAG_Pb];
        x_Concat_Pr = [x_Concat_Pr ZIG_ZAG_Pr];
    end
end

end