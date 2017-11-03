plotPoint(WP(:,1)); hold on
plotPoint(WP(:,2))
plotPoint(WP(:,3))
plotPoint(WP(:,4))
plotPoint(WP(:,5))
plotPoint(WP(:,6))



plot(p(1,1), p(1,2), 'ro');

for i = 1:5
    plot([WP(1,i); WP(1,i+1)] ,  [WP(2,i); WP(2,i+1)], 'g', 'LineStyle', '-')
end


