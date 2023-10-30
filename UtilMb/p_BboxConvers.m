%
% Bbox conversion from C (Sehbau) to Matlab for plotting with function
% rectangle, including normalization (to unit range)
% 
% The plotting function 'rectangle' expects [x y width height]
%
% IN    Bbox    bounding box as used by Sehbau [top/bot/lef/rit]
%       szV/H   vertical/horizontal image size
%
% OUT   Obox    bounding box [x y w h], normalized
% 
function [Obox] = p_BboxConvers(Bbox, szV, szH)

x       = Bbox(3) / szH;            % x-coord, normalized
h       = (Bbox(2)-Bbox(1)) / szV;  % height, normalized
w       = (Bbox(4)-Bbox(3)) / szH;  % width, normalized
y       = 1 - Bbox(1)/szV - h;      % 1- for Cartesian coord syst

Obox    = [ x y w h ];