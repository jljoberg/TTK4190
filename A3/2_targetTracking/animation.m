clc; close all
%%
L = 304.8;
x = p(:,1); y = p(:,2);

ax_x = [-12000 4000]; ax_y = [-16000 3000];
%x = p(:,2); y = p(:,1); % DO NOT DO THIS

%%
fig = figure('units','normalized','outerposition',[0 0 1 1]);
hold on; 
plot(p(:,2), p(:,1));
xlim(ax_x); ylim(ax_y);
plotPoint(WP(:,1)); plotPoint(WP(:,2))



pause(1)
clf

%%
F(size(p,1)) = struct('cdata',[],'colormap',[]);

hold on; 
plotPoint(WP(:,1)); plotPoint(WP(:,2))


for i = 1:size(p,1)    
    xlim(ax_x); ylim(ax_y);
    % BOAT
    tmpR=[cos(psi(i)) -sin(psi(i)); sin(psi(i)) cos(psi(i))];
    boat = tmpR*[L/2 .9*L/2 .5*L/2 -L/2 -L/2 .5*L/2 .9*L/2 L/2; 
              0 10 20 20 -20 -20 -10 0];
    hb1 = plot(y(i)+boat(2,:),x(i)+boat(1,:),'y');
    hb2 = patch(y(i)+boat(2,:),x(i)+boat(1,:),'y');
    
    % TARGET
    h = plot(p_target(i,2), p_target(i,1), 'k^');    
    
    % save frame / clear fig
    F(i) = getframe();
    delete(h); delete(hb1); delete(hb2);
end

%%
close;
fig2 = figure('units','normalized','outerposition',[0 0 1 1]);
xlim(ax_x); ylim(ax_y);
movie(F,3,1600)

