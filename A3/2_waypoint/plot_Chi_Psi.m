
figure; hold on;
%%
subplot(2,1,1);

h = plot(t,mod([chi_c, chi, psi],2*pi)*180/pi);
h(1).Color = 'r'; h(1).LineStyle = '--'; h(1).LineWidth = 2;
h(2).Color = 'b'; h(2).LineWidth = 1.2;
h(3).Color = [0 1 0]*0.7; h(3).LineStyle = '--'; h(3).LineWidth = 1.3;

legend('\chi_d', '\chi', '\psi');
grid on; xlabel('Time [s]'); ylabel('angle [deg]')
title('Course and heading with crab compensation')
if chi_i_on == 0
    title('Course and heading without crab compensation')
end



%%

subplot(2,1,2); 
plot(t,(mod(chi,2*pi)-mod(psi,2*pi))*180/pi);

legend('\beta')
grid on; xlabel('Time [s]'); ylabel('angle [deg]')
title('Crab angle')
