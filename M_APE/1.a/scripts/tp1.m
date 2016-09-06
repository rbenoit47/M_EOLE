%------------------------------------
% Nicolas Gasset 01/2008
% Robert Benoit  01/2011
% Joern Nathan   01/2013
%------------------------------------

clear all
close all
clc

global Ubar  sigmaU

%------------------------------------
% Pre-traitement
%------------------------------------

% fic = 'uHoraire.txt';
fic = 'u10Min1An.txt';

if not(exist('preTraitement', 'dir'))
    preTraitement(fic);
end

load preTraitement/Annee;
load preTraitement/Mois;
load preTraitement/Jour;
load preTraitement/Heure;
load preTraitement/Dir;
load preTraitement/U;

%------------------------------------
% Calcul de statistiques
%------------------------------------

n = length(U);

Ubar = mean(U);
% = sum(U)/n
fprintf('Ubar = %2.2f\n', Ubar)

sigmaU = std(U);
% = sqrt(1/(n-1)*(sum((U - mean(U)).^2)));
fprintf('sigmaU = %2.2f\n', sigmaU)

i_U08 = find(U<=08);
result1 = [Annee(i_U08) Mois(i_U08) Heure(i_U08) U(i_U08) Dir(i_U08)];

i_Ouest = find(Dir>=225 & Dir<315);
result2 = [Annee(i_Ouest) Mois(i_Ouest) Heure(i_Ouest) U(i_Ouest) Dir(i_Ouest)]; 

%------------------------------------
% Distribution de Weibull
%------------------------------------

c0=Ubar;
k0=sigmaU/Ubar;
x0=[c0;k0]; %estimation initiale juste pour demarrer solveur
options=optimset('Display','iter');   % Option to display output
[x,fval,exitflag]=fsolve(@gammaFunctions,x0);
c=x(1);k=x(2);
fprintf('c = %3.2f et k = %3.2f\n', c, k)

%------------------------------------
% Visualisation
%------------------------------------

% Evolution de la vitesse et de la direction
figure(1)
subplot(2,1,1)
plot(U)
axis tight
title('Evolution de la vitesse du vent')

subplot(2,1,2)
plot(Dir,'Color','r')
axis tight
title('Evolution de la direction du vent')
% Enregistre la figure en image
print -dpng -r300  resultats/evolutionVitesseDirection

% Nombre de secteurs voulus et initialisation de U_sect
figure(2)
binsU=[0 5 10 15 20];
%[HANDLES, DATA] = windRoseOctave(Dir, U, 'dtype', 'meteo', 'n', 12, 'di', binsU); %[0 5 10 15 20]);
[HANDLES, DATA] = windRose(Dir, U, 'dtype', 'meteo', 'n', 12, 'di', [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]);
print -dpng -r300  resultats/roseDeVent

% Histogramme
figure(3)
bin=1; % Taille des bin en m/s
X=0:bin:ceil(max(U));

hist(U,X)
xlim([0 ceil(max(U))])
title('Repartition du vent par vitesse (en nombre d enregistrement)')

hold on
PWeibull=(k/c)*((X+bin)/c).^(k-1).*exp(-((X+bin)/c).^k);
freqWeibull=PWeibull*n;
plot(freqWeibull,'r')
print -dpng -r300  resultats/histogrammeVitesseAnnuelle

freqBiVar
