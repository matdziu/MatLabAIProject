clear ; close all; clc
load('digitData.mat');

m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayDigits(sel);

input_layer_size  = 400;
hidden_layer_size = 25;
num_labels = 10;   

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
options = optimset('MaxIter', 3);
lambda = 1;

costFunction = @(p) costFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

fprintf('Neural network is learning using provided dataset...\n\n');

[nn_params, cost] = minimalizeFunction(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
         
pred = predict(Theta1, Theta2, X);
fprintf('Training set accuracy: %.2f%%\n', mean(double(pred == y)) * 100);
fprintf('Press enter to try...\n\n');
pause;

rp = randperm(m);

for i = 1 : m
    fprintf('\nDisplaying example...\n');
    displayDigits(X(rp(i), :));
    
    predictedDigit = pred(rp(i));
    shouldBeDigit = y(rp(i));
    
    if(predictedDigit == 10)
        predictedDigit = 0;
    end
    
    if(shouldBeDigit == 10)
        shouldBeDigit = 0;
    end
    
    fprintf('Predicted: %i\n', predictedDigit);
    fprintf('Should be: %i\n', shouldBeDigit);
    fprintf('Press enter...\n');
    pause;
end


