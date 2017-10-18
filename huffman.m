function[dict]=huffman(vectorCategorias)

p = probability(vectorCategorias);
categorias = 0:8;

dict = huffmandict(categorias,p);

end