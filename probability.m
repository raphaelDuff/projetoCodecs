function[p]=probability(x)

A=sum(x(:,:)==0);
B=sum(x(:,:)==1);
C=sum(x(:,:)==2);
D=sum(x(:,:)==3);
E=sum(x(:,:)==4);
F=sum(x(:,:)==5);
G=sum(x(:,:)==6);
H=sum(x(:,:)==7);
I=sum(x(:,:)==8);

pA=A/length(x);
pB=B/length(x);
pC=C/length(x);
pD=D/length(x);
pE=E/length(x);
pF=F/length(x);
pG=G/length(x);
pH=H/length(x);
pI=I/length(x);

p=[pA pB pC pD pE pF pG pH pI];

end