function [ feuillet ] = NTSfromLL( lat,lon, varargin )
%To obtain National Topographic System(NTS) sheet number(s) of the 1:250k series, e.g. 0A22, corresponding to a given position (lat,lon). It also generates the sheet numbers for a rectangle around that point
%FUNCTION_NAME - NTSfromLL   M_WEST
%NTSfromLL returns the list of NTS 1:250k sheet numbers (e.g. 022A)
%
% Syntax:  NTSfromLL(lat,lon,varargin)
%
% Inputs:
% 	lat - latitude of target point
% 	lon - longitude of target point
% 	varargin:  optional arguments
% 	one pair of:
% 	'boxsize', boxsize value
% 	'grid', grid structure from M_WEST
%
% Outputs:
% 	feuillet - list of sheet names
% 
% Example:
% ============================================
% 	>>NTSfromLL(48.7340,-67.8710);
% 	NTS sheet(s):
% 	Box size of ±50 km each side of point (2,2) in 3x3 matrix(i,j) below
% 		 '22F'    '22G'    '22G'
% 		 '22C'    '22B'    '22B'
% 		 '22C'    '22B'    '22B'
% 	Orientation is: j [1,2,3]--> [West, ,East], i [3,2,1]--> [South, ,North]
% 	i is row and j is column
% 	--------
% 	To perfectly align the box with your M_WEST grid region axes and total size,
% 	 which is defined by an M_WEST structure such as this one:
% 			Grd_dx: 100
% 			Grd_ni: 1000
% 			Grd_nj: 1000
% 		 Grd_iref: 501
% 		 Grd_jref: 501
% 		 Grd_latr: 48.7340
% 		 Grd_lonr: 292.1290
% 		 Grd_dgrw: 10
% 	... pass your M_WEST (meso or micro) grid structure in the call as follows:
% 	no lat and lon values needed!
% 	NTSfromLL([],[],'grid',your M structure)
% ============================================
% 
% Author: Robert Benoit, Ph.D.
% email address: robert.benoit.47@gmail.com 
%

format compact

nargs=nargin;
vin=varargin;

boxsize=100; %km
grid=struct([]);

if nargs > 2
	for i=1:length(vin)
		if isequal(vin{i},'boxsize')
			boxsize=vin{i+1};
		end
		if isequal(vin{i},'grid')
			grid=vin{i+1};
		end
	end
end

feuillet=[];
lon180=wrapTo180(lon);
%
function sheet=NTSsearch(lat,lon)
	sheet=[];
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
			i=max(i,1);
			region=reg16{i+(j-1)*4};
		case 'A'
			disp('Arctique et Haut Arctique pas fonctionnels')
			return
		case 'HA'
			disp('Arctique et Haut Arctique pas fonctionnels')
			return
	end
	sheet=[num2str(serie),region];
end
%
% ====================================
%
if isempty(grid)
	dgrw=0;
else
	disp('la structure grid fournie est utilisée')
	grid.Grd_output='--non requis--';
% 	disp(grid)
	iref=grid.Grd_iref;
	ni=grid.Grd_ni;
	if abs(ni/2-iref) >= 2
		disp('il faut que le point de reference (iref,jref) soit au centre de la grille.  Return')
		return
	end
	boxN=max(grid.Grd_ni,grid.Grd_nj);
	latr=grid.Grd_latr;
	lonr=grid.Grd_lonr;
	lat=double(latr);lon=double(lonr);
	lon180=wrapTo180(lonr);
	dgrw=double(grid.Grd_dgrw);
	mapscale=(1+sind(60))/(1+sind(latr));
	boxPS=double(boxN*grid.Grd_dx/1000);
	boxsize=boxPS/mapscale;
	azimuts=+dgrw+ 0:90:359;
	fprintf(['boxsize:%6.3f\nlat, lon=%7.3f, %7.3f\naxe X+ direction:%d °. axe Y+ direction:%d °\n' ...
		      'mapscale:%6.3f. grid size (km):%6.2f\n' ...
	        '0°=Nord, +90°=Est -90°=Ouest\n'],boxsize,lat,lon180,azimuts(2),azimuts(1), mapscale,boxPS);
end

s=boxsize/2*1000; % meters

nfeuil=1;
sheet=NTSsearch(lat,lon180); %lon);
feuillet=[];
feuillet{nfeuil}=sheet;
%now do a box around that point
%{
  [lon2,lat2,a21] = m_fdist(lon1,lat1,a12,s,spheroid)
 
  lat1 = GEODETIC latitude of first point (degrees)
  lon1 = longitude of first point (degrees)
  a12 = azimuth in degrees from first point to second point (forward)
  s = distance in meters  
  spheroid = (Optional) spheroid, defaults to 'wgs84'
 
  lat2, lon2 = second point (degrees)
  a21 = azimuth in degrees from second point to first point (backward)
        (Azimuths are in degrees clockwise from north.)
%}
azimuts=+dgrw+ 0:90:359;
for az=1:4
% 	azimuts(az)
	[lon2,lat2,a21] = m_fdist(lon,lat,azimuts(az),s);  %spheroid)
	lon2=wrapTo180(lon2);
	[lat2 lon2];
	sheet=NTSsearch(lat2,lon2);
	nfeuil=nfeuil+1;
	feuillet{nfeuil}=sheet; %{feuillet sheet};
end
azimuts=+dgrw+45:90:359;  %4 values
s=s*sqrt(2);
for az=1:4
% 	azimuts(az)
	[lon2,lat2,a21] = m_fdist(lon,lat,azimuts(az),s);  %spheroid)
	lon2=wrapTo180(lon2);
	nfeuil=nfeuil+1;
	[lat2 lon2];
	sheet=NTSsearch(lat2,lon2);
% 	display(sheet)
	feuillet{nfeuil}=sheet; %{feuillet sheet};
% 	feuillet={feuillet sheet};
end
disp('NTS sheet(s):')
disp(['Box size of ±',num2str(boxsize/2),' km each side of point (2,2) in 3x3 matrix(i,j) below'])
disp(feuillet([9 2 6]))
disp(feuillet([5 1 3]))
disp(feuillet([8 4 7]))

if isempty(grid)
	disp('Orientation is: j [1,2,3]--> [West, ,East], i [3,2,1]--> [South, ,North]')
	disp('i is row and j is column')
else
	disp('Orientation is: j [1,2,3]--> [-X, ,+X], i [3,2,1]--> [-Y, ,+Y],')
	disp('  where X, Y are the grid axes')
	disp('i is row and j is column')
end

if ~ boxsize == 100
	disp('--------')
	disp('To change boxsize (default is 2x±50=100 km), use this function call:')
	disp('NTSfromLL(latvalue,lonvalue,''boxsize'',boxsize value(in km))')
end
if isempty(grid)
	disp('--------')
	disp('To perfectly align the box with your M_WEST grid region axes and total size,')
	disp(' which is defined by an M_WEST structure such as this one:')
	%
	M.Grd_dx=100;
	M.Grd_ni=int32(1000);
	M.Grd_nj=int32(1000);
	M.Grd_iref=int32(501);
	M.Grd_jref=int32(501);
	M.Grd_latr=48.734;
	M.Grd_lonr=292.129;  % nb: 0-360 degrees
	M.Grd_dgrw=10;
	disp(M)
	%
	disp('... pass your M_WEST (meso or micro) grid structure in the call as follows:')
	disp('no lat and lon values needed!')
	disp('NTSfromLL([],[],''grid'',your M structure)')
end
end

