function vecBin = vec2Bin(vector)

counter = 0;
vecBin=[];
for i=1:length(vector)
    if vector(i)==0
        counter = counter +1;
    elseif vector(i)~=0 && counter ~=0
        converted = de2bi(counter,6);
        converted = fliplr(converted);
        vecBin = [vecBin converted];
        converted = de2bi(vector(i));
        converted = fliplr(converted);
        vecBin = [vecBin converted];
        counter=0;
    elseif vector(i)~=0 && counter == 0
        converted = de2bi(vector(i));
        converted = fliplr(converted);
        vecBin = [vecBin converted];
    end
end
if counter~=0
    converted = de2bi(counter,6);
    converted = fliplr(converted);
    vecBin = [vecBin converted];
end

end