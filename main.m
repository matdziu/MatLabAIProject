load('digitData.mat');
load('initWeights.mat');

m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayDigits(sel);