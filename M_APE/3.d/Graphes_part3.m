function [ ok ] = Graphes_part3( FSTmicrostats,Lon,Lat )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
format compact
%
if ~exist('dirCode','var'); 
	display('M_FST_win initialisé')
	init_M_FST_win; 
end
%
if ~exist(FSTmicrostats)
	disp([FSTmicrostats,' inexistant'])
	return
end
%
Lon=mod(Lon,-180);
%
ok=false;
IP1=-1;IP2=-1;IP3=-1; 
ETIKET=''; TYPVAR=''; verbose=0; CATALOG=0;DATEV=-1;incdat=0;monotonic=0;
%
% images de P/A micro (3.d)
%
ETIKET='GEOPHY_H';
[fstinfo,rec,fst2binOutput]=lire_fst_short(FSTmicrostats,'ME',  IP1,'NON',IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat,monotonic);
MEmicro=rec.data(:,:);
ETIKET='';
[fstinfo,rec,fst2binOutput]=   lire_fst_short(FSTmicrostats,'E1MI',IP1,'NON',IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat,monotonic);
E1MI=rec.data(:,:);
X=1:fstinfo.ni;
Y=1:fstinfo.nj;
[fstinfo,rec,fst2binOutput]= lire_fst_short(FSTmicrostats,'E1MI',IP1,'OUI',IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat,monotonic);
% 
LA=rec(1).data(:,:);LO=rec(2).data(:,:);
[Imicro,Jmicro]=LatLon2IJ(LO,LA,Lon,Lat);
if ~Imicro>0;disp('erreur de point cible');return;end
% 
Rgaz=287.;
RT0surg=8000.; %metres
pression=1000.*exp(-MEmicro/RT0surg);
T=15-0.0065*MEmicro;
Rho=100*pression./(Rgaz.*(T+273.16));
PsurA2D=Rho.*E1MI;
fprintf('Graphes_part3. Mat sur Microstats:\n I,J:(%i,%i),altitude sol:%5g\n pression:%5g,rho:%5g,T:%5g\n PsurA2D:%5g:\n',...
	Imicro,Jmicro,MEmicro(Imicro,Jmicro)',pression(Imicro,Jmicro)',...
	Rho(Imicro,Jmicro)',T(Imicro,Jmicro)',PsurA2D(Imicro,Jmicro)');
figure('units','normalized','outerposition',[0 0 1 1])
% X=1:fstinfo.ni;
% Y=1:fstinfo.nj;
contourf(X,Y,PsurA2D');colorbar;shading flat
hold on
contour(X,Y,MEmicro','w');
xlabel('FST i');ylabel('FST j');
title('PsurA micro: couleurs=rho(z)*E1MI (W/m2)+barre couleurs.  contours=relief');
hold off
nomPlot='PsurAmicroPlusME.png';
print('-dpng',nomPlot);
% kml
if exist('ge_plot') ~= 2
% 	addpath('\\MEC042672\Users\rbenoit\Documents\PSIRE\H15\BackupPartageOrlin\EOLE\projets\1_APE\data\MATLAB_APE_Octave\googleearth')
	'addpath ge_plot'
	return
end
FST2GE(LO,LA,PsurA2D,'PsurAmicro');
disp('fichier PsurAmicro.kml produit pour Google Earth')
%
ok=true;
end

