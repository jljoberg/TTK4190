clc; close all
figure; hold on;
plot(p(:,1), p(:,2)); xlim([-19000 4000]); ylim([-6000 2000]);
plotWP


pause(2)

hold off; plotWP; hold on; 
h0 = animatedline();

for i = 1:size(p,1)
    chi_x = 1000*cos(chi_c(i)) + p(i,1);  chi_y = 1000*sin(chi_c(i)) + p(i,2);
    psi_x = 700*cos(psi(i)) + p(i,1);     psi_y = 700*sin(psi(i)) + p(i,2);
    
    addpoints(h0, p(i,1), p(i,2));
    h1 = plot(p(i,1), p(i,2), 'b*');
    h2 = plot(LOS(i,1), LOS(i,2), 'g*');
    h3 = plot([p(i,1); chi_x], [p(i,2); chi_y], 'c');
    h4 = plot([p(i,1); psi_x], [p(i,2); psi_y], 'k');
    xlim([-19000 4000]); ylim([-6000 2000]); %ylim([-5000 1000])
    
    F(i) = getframe();
    %pause(0.005*10)
    delete(h1); delete(h2); delete(h3); delete(h4);
end

close;
movie(F,1,1600)

