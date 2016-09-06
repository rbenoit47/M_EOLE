%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pretraitment d'un fichier de donnees
% Nicolas Gasset 01/2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function preTraitement(fic)


close all
clc

%format shortG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lecture du fichier ascii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N] =  dlmread(fic);
whos N
d=N(1,1);l=length(num2str(d));
dfmt=sprintf('%s%i%s','%',l,'.0f')
Date_fichier = num2str(N(:,1),dfmt);  %, '%12.0f');
U_fichier = N(:,2);
Dir_fichier = N(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion de la date en annees, mois, jours et heures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Format de Date_fichier ='yyyymmddHHMM'

Annee_fichier = str2num(Date_fichier(:,1:4)); %#ok<*ST2NM>
Mois_fichier = str2num(Date_fichier(:,5:6));
Jour_fichier = str2num(Date_fichier(:,7:8));
Heure_fichier = str2num(Date_fichier(:,9:10)); 
length(Date_fichier(1,:));
if length(Date_fichier(1,:)) == 12
Minute_fichier = str2num(Date_fichier(:,11:12));
else
Minute_fichier = 0.*Heure_fichier;
end % octave: endif officiellement mais end passe
whos Minute_fichier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pour convertir vitesse à [m/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                             
U_fichier   = U_fichier / 3.6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtrage des données
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
igood_find = find(U_fichier>=0 & Dir_fichier ~= 999 );
fprintf('U_fichier: %i\n',numel(U_fichier))
fprintf('Annee_fichier: %i\n',numel(Annee_fichier))
fprintf('Heure_fichier: %i\n',numel(Heure_fichier))
fprintf('Uvalide: %i\n',numel(igood_find))
% igood_find = 1:length(Date_num_fichier); % pour aucun filtrage
% rejet = length(U_fichier)-length(igood_find)

Annee = Annee_fichier(igood_find);
Mois = Mois_fichier(igood_find);
Jour = Jour_fichier(igood_find);
Heure = Heure_fichier(igood_find);
Minute = Minute_fichier(igood_find);
Dir = Dir_fichier(igood_find);
U = U_fichier(igood_find);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ecriture des champs dans des fichier binaire matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mkdir preTraitement
%
save preTraitement/Annee Annee;
save preTraitement/Mois Mois;
save preTraitement/Jour Jour;
save preTraitement/Heure Heure;
save preTraitement/Minute Minute;
save preTraitement/Dir Dir;
save preTraitement/U U;

        
