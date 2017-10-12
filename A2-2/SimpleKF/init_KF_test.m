% Init file

h = 1/100; 

A = diag([1 1]); 
B = [1 1]';
C = [1 1]; 
E = [1 1]';

[PHI,DELTA] =  c2d(A,B,h);
[PHI,GAMMA] = c2d(A,E,h);
H = diag([1 1]); 
