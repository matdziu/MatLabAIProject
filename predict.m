function p = predict(Theta1, Theta2, X)

m = size(X, 1);

a_1 = [ones(m, 1) X];
z_2 = a_1 * Theta1';

a_2 = sigmoid(z_2);
a_2 = [ones(m, 1) a_2];
z_3 = a_2 * Theta2';

h_theta = sigmoid(z_3);

[~, p] = max(h_theta, [], 2);

end


