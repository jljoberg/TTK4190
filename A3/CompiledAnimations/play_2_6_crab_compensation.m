close all; clear F;
load('movie_2_6.mat')

fig2 = figure('units','normalized','outerposition',[0 0 1 1]);
xlim(ax_x); ylim(ax_y);
title('Path following, current on'); xlabel('East [m]'); ylabel('North [m]')
movie(F,2,48)