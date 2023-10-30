% 
% Concatenates histograms loaded from focal selections (.hsf file)
%
% Flat means no spatial selection (as opposed to spatial histogramming)
%
function [H len] = u_HistCatFlat(Uni, Biv, Nunf, Nbiv, Floc)

Huni 	= [Uni.Skl Uni.Rsg Uni.Arc Uni.Str];
Hbiv 	= [Biv.Skl Biv.Rsg Biv.Arc Biv.Str];
H       = [Huni Hbiv];

len.uni = length(Huni);
len.biv = length(Hbiv);
len.tot = len.uni + len.biv;

end

