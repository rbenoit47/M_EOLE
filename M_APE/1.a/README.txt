Scripts pour anémométrie
Tâche 1.a

Les scripts fournis sont dans répertoire 
MATLAB_APE\M_APE\1.a\scripts
dans lequel vous pouvez lire mais pas écrire.
Comme vous aurez à modifier certains d'entre eux, 
vous devez recopier ce répertoire sur votre zone de travail.

script principal:
	tp1.m  
script secondaire:  
	preTraitement.m 

Pour le graphe de rose de vents:  
fonction windRose.m

Fonction de calcul de coefficients weibull:
gammaFunctions.m

Script exemple de table de fréquence bivariée:
freqBiVar.m	(appelé par tp1.m)

-----------------------------------------
Script exemple de traitement (rose et fréquence bivariée):
CalculExempleHoraire.m
(il peut fonctionner avec des données horaires ou aux 10 minutes) 
qui sont fournies dans les deux fichiers suivants:

uHoraire.txt   exemple de données
u10Min1An.txt  exemple de données
-----------------------------------------

[preTraitement] produit par preTraitement.m  .  Purger répertoire au besoin 
[resultats]     doit exister au préalable: pour les graphiques produits  

Fonction optionnelle:
calcnbins.m:	calculates the "ideal" number of bins to use in a histogram, 
				using three possible methods. 
				(Freedman-Diaconis', Scott's and Sturges' methods.)
				URL:  http://www.mathworks.com/matlabcentral/fileexchange/21033-calculate-number-of-bins-for-histogram/content//calcnbins.m
				
				vous devez fournir la série chronologique (premier argument de cette fonction), dont vous voulez
				établir l'histogramme avec le nombre «optimal» de bins

==========
NOTES:
==========

Vous devez ajuster au moins tp1 pour utiliser VOS données.

attention ces scripts sont faits pour lire des données en format texte (txt) 
	avec les colonnes suivantes:
	
	DATE  (année,mois,jour,heure(,minutes))   ATTENTION AUX LARGEURS DE COLONNES (voir dans preTraitement)
	vitesse
	direction

==================================================================================
CAVEAT:
Si le répertoire preTraitement existe, tp1 ne réexécute PAS preTraitement.
DONC ... éliminer le répertoire preTraitement lorsqu'on change les données à traiter.
==================================================================================
	
Les données sont filtrées (preTraitement) pour éliminer 
	les valeurs manquantes (vitesse<0 et direction=999)
	
Trois graphiques sont produits et enregistrés en PNG sous resultats.  
	Série chronologique (lignes sous MATLAB, points sous Octave)
	Rose de vents
	Courbe de fréquence et approximation Weibull
	
