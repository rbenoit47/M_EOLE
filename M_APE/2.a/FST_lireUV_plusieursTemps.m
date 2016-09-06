function [u,v,t]=FST_lireUV_plusieursTemps(Casedir,IP1,pas)
%FUNCTION_NAME - FST_lireUV_plusieursTemps 
%FST_lireUV_plusieursTemps extracts wind vectors for 
%       multiple time steps from a set of MC2 output files
%       stored in a single directory and named
%       as dm1998010100-00-00_000*p.fst
%
% Syntax:  [u,v,t]=FST_lireUV_plusieursTemps(Casedir,IP1,pas)
%
% Inputs:
%    Casedir - path to directory where MC2 case run is stored
%              without the final \output part in it
%    IP1 - index of FST vertical level for desired wind vectors
%    pas - increment (integer) in timestep number for the extraction
%
% Outputs:
%    u - extracted u-components (x,y,:) for all chosen times
%    v - extracted v-components (x,y,:) for all chosen times
%    t - time values (in step units) of all chosen times

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% For more information, see <a href="matlab: 
% web('http://www.mathworks.com')">the MathWorks Web site</a>,
%   see also <a href="matlab: 
% web('http://www.eos.ubc.ca/~rich/map.html')">the M_MAP Web site</a>
% 
% Author: Robert Benoit, Ph.D.
% email address: robert.benoit.47@gmail.com 
%
% This software is provided "as is" without warranty of any kind. But
% it's mine, so you can't sell it.
%
%------------- BEGIN CODE --------------
% FST_lireUV_plusieursTemps Casedir=repertoire MC2 contenant la simulation voulue.  M_WEST
format compact
Casedir=[Casedir,'\'];  % au cas ou
if ~exist (Casedir,'dir'); APEmsg1('repertoire Casedir fourni inexistant','exit');end
%
init_M_FST_win
%
% boucle sur le numero de pas de temps. ici 000, 090,180, 270
%
u=[]; v=[]; t=[];
i=0;
for pas=pas
    i=i+1;
    pas_3car=num2str(pas,'%03i');
    FST=[Casedir,'\output\dm1998010100-00-00_000' pas_3car 'p.fst'] 
    NOMVAR='UU';
    %
    IP2=-1;
    IP3=-1;
    ETIKET='';
    TYPVAR='';
    DATEV=-1;
    LALO='NON';  CATALOG=0;    verbose=0;   incdat=0;    monotonic=0;
    [fst_info,rec,fst2binOutput]=lire_fst_short(FST,NOMVAR,IP1,LALO,IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat,monotonic);
    UU=rec.data;
    NOMVAR='VV';
    [fst_info,rec,fst2binOutput]=lire_fst_short(FST,NOMVAR,IP1,LALO,IP2,IP3,ETIKET,TYPVAR,DATEV,CATALOG,verbose,incdat,monotonic);
    VV=rec.data;
    t(i)=pas;
    u(:,:,i)=UU*0.514444444;  %1 knot = 0.514444444 meters / second
    v(:,:,i)=VV*0.514444444;
end
end
