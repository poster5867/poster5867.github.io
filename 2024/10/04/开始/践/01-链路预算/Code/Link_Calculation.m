% @ DATA: 2024-10-12-17:19:49
% @ Author: Poster
% @ Description:
% @ Notes:
%------------------------------------------%
fc = 14.7e3; % carrier frequency(MHz)
d = 550; % distance(km)
L = 32.45 + 20 * log10(fc) + 20 * log10(d); % Free Space Path Loss(dB)
disp(['自由空间损耗: ', num2str(L), 'dB']);
%------------------------------------------%
EIRP = 20; % Effective Isotropic Radiated Power(dBm)