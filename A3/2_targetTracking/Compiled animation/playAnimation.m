clear all; close all; %#ok<*CLALL>
load('movieSetup.mat')

figure('units','normalized','outerposition',[0 0 1 1]);
xlabel('East'); ylabel('North');
xlim(ax_x); ylim(ax_y);

try %#ok<*TRYNC>
    movie(F,2,140)
end