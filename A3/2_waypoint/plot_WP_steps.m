figure;
dec = 20;

%fig = figure('units','normalized','outerposition',[0 0 1 1])
plotWP; hold on; 
h0 = animatedline();

for i = 1:dec:size(p,1)
    chi_x = 1000*cos(chi_c(i)) + p(i,1);  chi_y = 1000*sin(chi_c(i)) + p(i,2);
    psi_x = 700*cos(psi(i)) + p(i,1);     psi_y = 700*sin(psi(i)) + p(i,2);
    
    addpoints(h0, p(i,1), p(i,2));
    h1 = plot(p(i,1), p(i,2), 'b*');
    h4 = plot([p(i,1); psi_x], [p(i,2); psi_y], 'k');
    xlim([-19000 4000]); ylim([-6000 2000]); %ylim([-5000 1000])

end


