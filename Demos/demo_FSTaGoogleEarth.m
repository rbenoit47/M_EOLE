function []=demo_FSTaGoogleEarth()
%  ============================================================
%  ce script demo_FSTaGoogleEarth.m 
%  montre un exemple d'exportation de contenu FST vers Google Earth
%  sous forme de contours en couleur
%
%  R Benoit ÉTS 2013
%  ============================================================
%
clear

init_M_FST_win   %ceci est requis et demarre usage du plugin M_FST_win
%
%  ============================================================
Me=mfilename();
w=which(Me);
[pathstr,~,~]=fileparts(w);
FST=[pathstr,'\MesoWEStats.fst'];
%  pour separer au besoin le nom du FST en ses composantes
[~, FSTname, ~] = fileparts(FST);  
clear pathstr
% ================================================================
IP1=-1;IP2=-1;IP3=-1;ETIKET='';
TYPVAR='';
verbose=0;
CATALOG=0;
DATEV=2;     %Force mauvaise date  mais ..
incdat=0;    %Ne pas calculer de date de validité .. donc ca passe!
LALO='non';
nomvar='EU';
[fst_info,EU,fst2binOutput]=lire_fst_short(FST,nomvar,...
    IP1,LALO,IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat);
LALO='oui';
[fst_info,LALO2D,fst2binOutput]=lire_fst_short(FST,nomvar,...
    IP1,LALO,IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat);
whos LALO2D
LAT=LALO2D(1).data;LON=LALO2D(2).data;
%LAT=(LALO2D(:,:,1));LON=(LALO2D(:,:,2));  %single single
EUs=EU.data; %(EU);  %single
whos LAT LON EUs

% convertisseur a Google Earth fonction en single et non pas en double
try
    FST2GE(LON,LAT,EUs,[nomvar 'From_' FSTname])
catch
    disp('Les fonctions googleearth requises ne sont pas accessibles')
    disp('Au besoin extraire le googleearth_matlab.zip fourni')
    disp('Et faire addpath sur le folder googleearth et ses sous-folders ')
    disp('Et recommencer le demo')
    return
end
disp('Le fichier de sortie, *.kml, est affichable dans Google Earth')
disp(['Ouvrir ou double clic sur ' nomvar 'From_' FSTname '.kml'])
end
