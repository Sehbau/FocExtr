%
% Creates bounding box parameters (TBLR) for a variety of image partitions,
% called zones here. Can be used for extracting focii or for partitioning
% the image itself.
%
% Types of paritioning: 
% - 4 quarters and center
% - stripes vertical and horizontal for (3 or 4 in number)
% 
% Degree of overlap: overlapping or separate.
%
% ai plcDscxZon.m
%
% IN   szM    map size
%      idx    zero-indexing for C, one-indexing for matlab
% OUT  S      struct with zones
%
function S = u_ZonesBboxes( szM, idx )

hgt     = szM(1);
wth     = szM(2);

%% ----------   Quarters & Center   ----------
hh      = hgt / 2;
wh      = wth / 2;

Q4C      = zeros(5,4,'int16');
Q4C(1,:) = [ idx  hh   idx  wh ];      % top left
Q4C(2,:) = [ hh+1 hgt  idx  wh ];      % bottom left
Q4C(3,:) = [ idx  hh,  wh+1 wth ];     % top rite
Q4C(4,:) = [ hh+1 hgt  wh+1 wth ];     % bottom rite

h4      = hgt / 4;
w4      = wth / 4;
Q4C(5,:) = [ h4  h4+hh   w4  w4+wh ];   % center

S.Q4C.Bbox = Q4C( [5 1 3 2 4], :);
S.Q4C.aLab = {'Cen' 'TL' 'TR' 'BL' 'BR'};
S.Q4C.nZon = 5;

%% ----------   Stripes Overlapping   ----------
S.Ola3 	= uu_ZonesOlap( szM, 3, idx);

S.Ola3.Horz.aLab = {'TopOla' 'MidOla' 'BotOla'};
S.Ola3.Vert.aLab = {'LefOla' 'MidOla' 'RitOla'};


S.Ola4  = uu_ZonesOlap( szM, 4, idx);

S.Ola4.Horz.aLab = {'TopOla' 'Above' 'Below' 'BottomOla'};
S.Ola4.Vert.aLab = {'LefOla' 'LeftOfC' 'RiteOfC' 'RitOla'};


%% -----------   Stripes Separate   ---------
S.Sep3   = uu_ZonesSepr( szM, 3, idx);

S.Sep3.Horz.aLab = {'TopSep' 'MidSep' 'BotSep'};
S.Sep3.Vert.aLab = {'LefSep' 'MidSep' 'RitSep'};

S.Sep4   = uu_ZonesSepr( szM, 4, idx);


%% -----------   Mesh 3   ---------
S.Msh3          = struct;
S.Msh3.Bbox     = [S.Ola3.Horz.Bbox; S.Ola3.Vert.Bbox];
S.Msh3.aLab     = [S.Ola3.Horz.aLab  S.Ola3.Vert.aLab];
S.Msh3.aLab{2}  = 'MidOlaH';
S.Msh3.aLab{5}  = 'MidOlaV';
S.Msh3.nZon     = 6;

%% -----------   Mesh 3 (separate; non-olap)  ---------
S.Msh3sep          = struct;
S.Msh3sep.Bbox     = [S.Sep3.Horz.Bbox; S.Sep3.Vert.Bbox];
S.Msh3sep.aLab     = [S.Sep3.Horz.aLab  S.Sep3.Vert.aLab];
S.Msh3sep.aLab{2}  = 'MidSepH';
S.Msh3sep.aLab{5}  = 'MidSepV';
S.Msh3sep.nZon     = 6;

end % MAIN


%% ===============   uu_ZonesOlap   ===============
%
% Overlapping zones (bands)
%
function S = uu_ZonesOlap( szM, nZon, idx )

szV     = szM(1);
szH     = szM(2);

Bx      = zeros( nZon, 4, 'int16');
HorSpc  = round( linspace( idx, szH, nZon+2) );
for b = 1:nZon                   % -----  vertical  -----
    Bx(b,:)  = [ idx  szV  HorSpc(b) HorSpc(b+2) ]; 
end
S.Vert.Bbox  = Bx;
S.Vert.nZon  = nZon;

VerSpc  = round( linspace( idx, szV, nZon+2) );
for b = 1:nZon                   % -----  horizontal  -----
    Bx(b,:)  = [ VerSpc(b)  VerSpc(b+2)  idx  szH ]; 
end
S.Horz.Bbox  = Bx;
S.Horz.nZon  = nZon;

end % SUB


%% ===============   uu_ZonesSepr   ===============
%
% Separate zones (bands)
%
function S = uu_ZonesSepr( szM, nZon, idx)

szV     = szM(1);
szH     = szM(2);

Bx      = zeros(nZon,4, 'int16');
HorSpc  = round( linspace( idx, szH, nZon+1) );
for b = 1:nZon                   % -----  vertical  -----
    Bx(b,:)  = [ idx  szV  HorSpc(b) HorSpc(b+1) ]; 
end
S.Vert.Bbox  = Bx;
S.Vert.nZon  = nZon;


VerSpc  = round( linspace( idx, szV, nZon+1) );
for b = 1:nZon                   % -----  horizontal  -----
    Bx(b,:)  = [ VerSpc(b)  VerSpc(b+1)  idx  szH ]; 
end
S.Horz.Bbox  = Bx;
S.Horz.nZon  = nZon;

end % SUB
