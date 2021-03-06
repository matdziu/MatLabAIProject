function [J, grad] = costFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

m = size(X, 1);        
J = 0;

Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

a_1 = [ones(m, 1) X];
z_2 = a_1 * Theta1';

a_2 = sigmoid(z_2);
a_2 = [ones(m, 1) a_2];
z_3 = a_2 * Theta2';

h_theta = sigmoid(z_3);

for k = 1 : num_labels
    y_k = y == k;
    h_thetak = h_theta(:, k);
    J_k = 1 / m * sum(-y_k .* log(h_thetak) - (1 - y_k) .* log(1 - h_thetak));
    J = J + J_k;
end

regularization = lambda / (2 * m) * (sum(sum(Theta1(:, 2:end) .^ 2)) ...
    + sum(sum(Theta2(:, 2:end) .^ 2)));
J = J + regularization;


for t = 1 : m
    delta_3 = zeros(1, num_labels);
    for k = 1 : num_labels
        y_k = y(t) == k;
        delta_3(k) = h_theta(t, k) - y_k;
    end
    
    delta_2 = Theta2' * delta_3' .* sigmoidGradient([1, z_2(t, :)])';
    delta_2 = delta_2(2:end);

    Theta1_grad = Theta1_grad + delta_2 * a_1(t, :);
    Theta2_grad = Theta2_grad + delta_3' * a_2(t, :);
end

Theta1_grad = Theta1_grad / m;
Theta2_grad = Theta2_grad / m;

Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + lambda / m * Theta1(:, 2:end);
Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + lambda / m * Theta2(:, 2:end);


grad = [Theta1_grad(:) ; Theta2_grad(:)];

end