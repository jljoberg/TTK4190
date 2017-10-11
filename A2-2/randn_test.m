%%
clc
N = 1e+7;
x = zeros(1,N);

for i = 0.1:0.1:1
    v = i;
    for i = 1:N
        x(i) = sqrt(v)*randn();
    end
    var(x);
    disp([v, var(x)]);
end

%%
% histogram(x)