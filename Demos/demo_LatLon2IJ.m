function []=demo_LatLon2IJ()
%
%  demonstration de la fonction LatLon2IJ
%  LatLon2IJ calcule les indices de grille I,J du point de maillage
%  le «plus près» des coordonnées Lat Lon du point d'intérêt
%
clear
Lat=47.1; Lon=-65.;  % le point d'intérêt
Me=mfilename();
w=which(Me);
[pathstr,~,~]=fileparts(w);
FST=[pathstr,'\MesoWEStats.fst'];
% FST='MesoWEStats.fst';  %fichier contenant le maillage considéré
%
nomvar='EU';  %  nom du maillage d'intérêt=un champ 2D du FST
%
init_M_FST_win   %ceci est requis et demarre usage du plugin M_FST_win
%
verbose=0;
CATALOG=0;  %mettre à 1 pour voir contenu du FST, a l écran
IP1=-1;IP2=-1;IP3=-1; %trois cles de recherche  
LALO='OUI';
ETIKET='';
TYPVAR='';
DATEV=-1;incdat=0; %Ne pas calculer de date de validité
fst2binOutput='';
[fst_info,LALO2D,fst2binOutput]=lire_fst_short(FST,nomvar,...
    IP1,LALO,IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat);
LAT2D=LALO2D(1).data;LON2D=LALO2D(2).data;
% whos LAT2D LON2D
%
[ILL,JLL]=LatLon2IJ(LON2D,LAT2D,Lon,Lat);
%
fprintf('Lat Lon du point cible= %d %d\n',Lat,Lon)
fprintf('I,J du point cible:(%d,%d)\n',ILL,JLL)
%
if isempty(ILL)
    disp('pas de solution sur ce maillage. Réessayer')
    Lat 
    Lon
else
[C,h]=contour(LAT2D');clabel(C,h);hold on;
[C,h]=contour(LON2D');clabel(C,h);
plot(single(ILL),single(JLL),'o',...
    'MarkerFaceColor','r','MarkerSize',5,'MarkerEdgeColor','k')
title({'Lat2D,Lon2D transposes + marqueur au point cible';...
    ['I,J du point:(',num2str(ILL),',',num2str(JLL),')'];
    ['Lat Lon du point cible=(',num2str(Lat),',',num2str(Lon),')'] });
    %...    'Lat Lon du point cible=',num2str(Lat),num2str(Lon)])
hold off
end

end







