clc; close all; clear F
%%
dec = 4; %4
L = 304.8;
x = p(:,1); y = p(:,2);
ax_x = [-6000 2000]; ax_y = [-19000 4000];

fig = figure('units','normalized','outerposition',[0 0 1 1]); 
hold on; title('Path following, current on'); xlabel('East [m]'); ylabel('North [m]')

tmp = plot(p(:,2), p(:,1)); xlim(ax_x); ylim(ax_y);
plotWP

pause(1)
delete(tmp)

%% 
h0 = animatedline();

for i = 1:dec:size(p,1)
    
    % BOAT
    tmpR=[cos(psi(i)) -sin(psi(i)); sin(psi(i)) cos(psi(i))];
    boat = tmpR*[L/2 .9*L/2 .5*L/2 -L/2 -L/2 .5*L/2 .9*L/2 L/2; 
              0 10 20 20 -20 -20 -10 0];
    hb1 = plot(y(i)+boat(2,:),x(i)+boat(1,:),'y');
    hb2 = patch(y(i)+boat(2,:),x(i)+boat(1,:),'y');
    
    
    addpoints(h0, p(i,2), p(i,1));
    h1 = plot(LOS(i,2), LOS(i,1), 'g*');
    
    xlim(ax_x); ylim(ax_y);
    F(ceil(i/dec)) = getframe();
    delete(h1); delete(hb1); delete(hb2)
end
%%
close;
fig2 = figure('units','normalized','outerposition',[0 0 1 1]);
xlim(ax_x); ylim(ax_y);
title('Path following, current on'); xlabel('East [m]'); ylabel('North [m]')
movie(F,1,40)


