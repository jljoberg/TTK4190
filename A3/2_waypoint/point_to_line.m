close all;

pk = [3000; 3000];
pk1 = [0; 0];
q = [1200; 200];

pointOnLine = @(s, pk, pk1) pk + (s)*(pk1-pk);

s0 = 1/2;
delta = 1/4;
threshold = 0.1;
diff = 15*threshold;
i = 0;

while diff > threshold
    sA = s0 + delta;
    sB = s0 - delta;
    dA = norm(q - pointOnLine(sA,pk,pk1) );
    dB = norm(q - pointOnLine(sB,pk,pk1) );
    if dA < dB
        s0 = sA;
    else
        s0 = sB;
    end
    
    diff = norm(pk-pk1)*abs(sA - sB);
    delta = delta/2;
    i = i+1;
end
s = (sA+sB)/2;
e = pointOnLine(s,pk,pk1);

LAD = 300;
LOS = pointOnLine(s + LAD/norm(pk1-pk), pk, pk1);

aim = LOS - q;
chi = atan2(aim(2), aim(1)) * rad2deg

hold on;
plot([pk(2) pk1(2)], [pk(1); pk1(1)]);
plot(q(2),q(1), 'k*')
plot(e(2),e(1), 'r*')
plot(LOS(2),LOS(1), 'b*')

xlim([0 1500])
