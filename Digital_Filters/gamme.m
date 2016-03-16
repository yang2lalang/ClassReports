function [gam,t,phi] = gamme(duree,fs)

% [do re mi fa sol la si do]
% [C D E F G A B C]
freqnotes = [262 294 330 349 392 440 494 523];

t = 0:1/fs:duree;
phi = 0; % phase initiale nulle
gam=[];
for ii=1:8, 
    gam = [gam ; sin(2*pi*freqnotes(ii)*t+phi)'];
    % optionnel - assurer la continuité de la phase 
    phi = 2*pi*freqnotes(ii)*(t(end)+1/fs)+phi; 
end
N = length(gam);
t = (0:N-1)/fs;

