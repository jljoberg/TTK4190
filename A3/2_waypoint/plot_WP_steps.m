figure('units','normalized','outerposition',[0 0 1 1]);
dec = 20;
L = 304.8;
x = p(:,1); y = p(:,2);


%fig = figure('units','normalized','outerposition',[0 0 1 1])
plotWP; hold on; 

for i = 1:dec:size(p,1)
    tmpR=[cos(psi(i)) -sin(psi(i)); sin(psi(i)) cos(psi(i))];
    boat = tmpR*[L/2 .9*L/2 .5*L/2 -L/2 -L/2 .5*L/2 .9*L/2 L/2; 
              0 10 20 20 -20 -20 -10 0];
    hb1 = plot(y(i)+boat(2,:),x(i)+boat(1,:),'y');
    hb2 = patch(y(i)+boat(2,:),x(i)+boat(1,:),'y');

    xlim([-6000 2000]); ylim([-19000 4000]);% xlim([-19000 4000]);

end

axis equal

