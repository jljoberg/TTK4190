
%%
distance = zeros(size(p,1),1);
for i = 1:size(p,1)
    distance(i) = norm(p(i,:) - p_target(i,:));
end

%%
figure; hold on; 
plot(t,distance); plot([0; t(end)],[400; 400])
xlabel('distance [m]'); ylabel('time [s]'); title('Target tracking, distance')
legend('Distance to target', 'Desired distance')