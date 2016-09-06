function [ ok, fnames ] = APEgenHOMEtree( StudentHome )
%FUNCTION_NAME - APEgenHOMEtree   M_WEST
%   APEgenHOMEtree génère l'arborescence de répertoires pour le projet APE
%   (cours SYS847 ÉTS)
%
% Syntax:  [ ok, fnames ] = APEgenHOMEtree( StudentHome )
%
% Inputs:
%    StudentHome - répertoire racine pour le projet APE de l'usager (par exemple
%    C:\Users\rbenoit\APEhome)  DOIT SE TERMINER PAR APEhome
%
% Outputs:
%    ok - statut de l'exécution de la fonction= true/false
%    fnames - les noms des répertoires générés (char)
%
% Example: 
%    [ ok, fnames ] = APEgenHOMEtree( 'C:\Users\rbenoit' )
%    fnames = 
%     'C:\Users\rbenoit\APEhome'
%     'C:\Users\rbenoit\APEhome\1'
%     'C:\Users\rbenoit\APEhome\1\a'
%     'C:\Users\rbenoit\APEhome\1\b'
%     'C:\Users\rbenoit\APEhome\2'   etc…………..
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: getUserHome,  M_WEST_startup

% Author: Robert Benoit, Ph.D.
% email address: robert.benoit.47@gmail.com 

%------------- BEGIN CODE --------------

% besoin de GetFullPath

ok=false;fnames=[];
Here=pwd;
CodePath=APEgetCodePath();
FixedTreeZip=strcat(CodePath,'/APEhomeFIXED.zip');
if exist (StudentHome)
    APEmsg1(['Directory ',StudentHome,' already exist. Should not'],'exit');
else
	mkdir (StudentHome)
	cd (StudentHome)
	StdHomePath=pwd;
	unzip(FixedTreeZip);%,StudentHome);
	%  les noms en absolu
	fnames=dirwalk(StdHomePath);
end
ok=true;
cd (Here)
end

