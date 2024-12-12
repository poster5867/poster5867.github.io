% @ DATA: 2024-10-12-17:19:49
% @ Author: Poster
% @ Description:
% @ Notes:
clc; clear; close all
%------------------------------------------%
%: 通信距离计算
h = 550; % 轨道高度(km)
theta_deg = 25; % 地球站至卫星的仰角(°)
theta = deg2rad(theta_deg); % rad
disp(['地面通信终端天线仰角: ', num2str(theta_deg), '°']);
RE = 6378.14; % 地球半径(km)
beta = asin(RE / (RE + h) * cos(theta)); % 卫星到地心与到地球站的夹角(rad)
beta_deg = beta * 180 / pi; % °
disp(['卫星天线对地张角: ', num2str(beta_deg), '°']);
alpha = pi / 2 - beta - theta; % 地心角(rad)
d = RE * sin(alpha) / sin(beta); % 通信距离(km)
disp(['通信距离: ', num2str(d), 'km']);
%------------------------------------------%
%: 自由空间损耗计算
fc = 11.7e3; % carrier frequency(MHz)
Lp = 32.45 + 20 * log10(fc) + 20 * log10(d); % Free Space Path Loss(dB)
disp(['自由空间损耗: ', num2str(Lp), 'dB']);
%------------------------------------------%
EIRP = 36.7; % Effective Isotropic Radiated Power(dBm)
disp(['有效全向辐射功率EIRP: ', num2str(EIRP), 'dBm']);
%------------------------------------------%
%: 其他损耗
La = 2.4; % Atmospheric Loss(dB)
Lr = 1; % Other Loss(dB)
Lfr = 0; % 接收馈线损耗(dB)(天线指向损失;极化损失)
L = Lp + La + Lr + Lfr; % Total Loss(dB)
%------------------------------------------%
%: 地面终端 G/T
G = 32.8; % 天线增益(dBi)
eta = 0.5; % 天线效率
aperture = 2; % 天线孔径(m)
lambda = 3e8 / (fc * 1e6); % 波长(m)
G_c = 10 * log10(eta * 4 * pi * aperture / (lambda ^ 2)); % 抛物面天线增益(dBi)
T = 300; %系统噪声温度
GT = G - 10 * log10(T); % 系统G/T比率(dB/K)
disp(['系统G/T值: ', num2str(GT), ' dB/K']);
%------------------------------------------%
%: 接收机载噪比
B = 250e6; % 接收机带宽(MHz)
disp(['接收机带宽: ', num2str(B / 1e6), 'MHz']);
cons = -228.6; % 玻尔兹曼常数(dBW/K/Hz)
CN = EIRP - L + GT - 10 * log10(B) - cons; % 接收机接收功率(dBm)
disp(['载噪比C/N: ', num2str(CN), 'dB']);
