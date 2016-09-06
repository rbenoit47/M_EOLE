format compact
mydata='.\1a\scripts\uHoraire.txt';  %uHoraire.txt  u10Min1An.txt
M=dlmread(mydata);
% M(:,1:3)=date, vitesse, direction
%oter les manquants
Umiss=-9.99;
Dmiss=999;
iMvalid=find(M(:,2)~=Umiss & M(:,3)~=Dmiss);
display(['Nb données total=',num2str(numel(M(:,1)))])
display(['Nb données valides=',num2str(numel(iMvalid))])
Mvalid=M(iMvalid,:);
U=Mvalid(:,2);D=Mvalid(:,3);
binsU=0:2:26;
[handles,DATA]=windRose(D,U,...
	'n',12,'dtype','meteo','di',binsU); %
%
freqBiVar
%
