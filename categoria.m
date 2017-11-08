function[vCategoria]=categoria(vector)
vCategoria=zeros(size(vector));
%   Entra um vetor e sai vetor de categorias
for i=1:length(vector)
    
    if vector(i)==0
        vCategoria(i)=0;
        
    elseif vector(i)==1||vector(i)==-1
        vCategoria(i)=1;
        
    elseif vector(i)<=3&&vector(i)>0||vector(i)>=-3&&vector(i)<0
        vCategoria(i)=2;
        
    elseif vector(i)<=7&&vector(i)>0||vector(i)>=-7&&vector(i)<0
        vCategoria(i)=3;
        
    elseif vector(i)<=15&&vector(i)>0||vector(i)>=-15&&vector(i)<0
        vCategoria(i)=4;
        
    elseif vector(i)<=31&&vector(i)>0||vector(i)>=-31&&vector(i)<0
        vCategoria(i)=5;
        
    elseif vector(i)<=63&&vector(i)>0||vector(i)>=-63&&vector(i)<0
        vCategoria(i)=6;
        
    elseif vector(i)<=127&&vector(i)>0||vector(i)>=-127&&vector(i)<0
        vCategoria(i)=7;
        
    elseif vector(i)<=255&&vector(i)>0||vector(i)>=-255&&vector(i)<0
        vCategoria(i)=8;
        
    end
end

end