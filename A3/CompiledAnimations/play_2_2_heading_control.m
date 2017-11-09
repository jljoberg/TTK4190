close all; clear F;
load('movie_2_2.mat')

fig2 = figure('units','normalized','outerposition',[0 0 1 1]);
xlim(ax_x); ylim(ax_y);
title('Path following, \psi_d = \chi_d'); xlabel('East [m]'); ylabel('North [m]')
movie(F,2,48)