NU=numel(U);
freqs=DATA/NU;  %normaliser DATA vers 0-1
[NbDir,NbU]=size(DATA);
% imprimer la table bi variée
fprintf('======================================\n')
fprintf('\nEXEMPLE TABLE FREQUENCE BIVARIEE\n')
fprintf('dir(°) \n')
fprintf('U       ')
for i=1:NbU
fprintf('%5d ',binsU(i));
end  %for
fprintf('somme U\n');
for j=1:NbDir
ddd=(j-1)*360/NbDir;
ddd=mod(-270-ddd,360);
fprintf('%7d ',ddd); %(j-1)*360/NbDir)
for i=1:NbU
fprintf('%5.3f ', freqs(j,i))
end  %for
fprintf('%5.3f\n',sum(freqs(j,:)));
end  %for
fprintf('    360                         %5.3f\n',sum(sum(freqs(:,:))));

fprintf('somme dir\n        ');
for i=1:NbU
fprintf('%5.3f ',sum(freqs(:,i)));
end  %for
fprintf('%5.3f\n',sum(sum(freqs(:,:))));
fprintf('======================================\n')

