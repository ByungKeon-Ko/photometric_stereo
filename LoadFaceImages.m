
function [ambimage, imarray, lightdirs] = LoadFaceImages( pathname );

filename = [pathname 'yaleB01_P00_Ambient.pgm'];
ambimage = getpgmraw(filename);


