function [ feuillet ] = NTSfromLL( lat,lon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
feuillet=[];
lon180=wrapTo180(lon);
lone=-48;lono=-144;
lats=40;latn=88;
tns=4;
% test pour dans Canada
if lon180 <= lone && lon180 >= lono
else
	disp(['longitude not in Canada...',num2str(lon)])
end
if lat >= lats && lat <= latn
else
	disp(['latitude not in Canada...',num2str(lat)])
end
zone=[];
teo=8;
regsplit=16;
if lat <= 68;zone='S';
elseif lat <= 80;zone='A';regsplit=8;
elseif lat <= 88;zone='HA';teo=16;lone=-56;regsplit=8;
end
serdec=floor((lone-lon180)/teo);
seruni=floor((lat-lats)/tns);
serie=10*serdec+seruni;
% region [A to P]
%{
M N O P
L K J I
E F G H
D C B A
%}
reg16={'A','B','C','D','H','G','F','E','I','J','K','L','P','O','N','M'};
latLR=lats+seruni*tns;
lonLR=lone-serdec*teo;
switch zone
	case 'S'
		dlat=tns/4;dlon=teo/4;
		j=ceil((lat-latLR)/dlat);
		i=ceil((lonLR-lon)/dlon);
		region=reg16{i+(j-1)*4};
	case 'A'
		disp('Arctique et Haut Arctique pas fonctionnels')
		return
	case 'HA'
		disp('Arctique et Haut Arctique pas fonctionnels')
		return
end
feuillet=[num2str(serie),region];
end

