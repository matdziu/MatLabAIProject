function displayDigits(digitData)

colormap(gray);

[m, n] = size(digitData);
example_width = round(sqrt(size(digitData, 2)));
example_height = (n / example_width);

display_rows = floor(sqrt(m));
display_cols = ceil(m / display_rows);

pad = 1;

display_array = - ones(display_rows * (example_height + pad) + pad, ...
                       display_cols * (example_width + pad) + pad);

curr_ex = 1;

for i = 1 : display_rows
	for j = 1 : display_cols
        if curr_ex > m,   
			break;             
        end    
        
		display_array((1:example_height) + pad + (i - 1) * (example_height + pad), ...
		              (1:example_width)+ pad + (j - 1) * (example_width + pad)) = ...
						reshape(digitData(curr_ex, :), example_height, example_width);
                    
		curr_ex = curr_ex + 1;
        
	end
	if curr_ex > m, 
		break; 
	end
end

imagesc(display_array, [-1, 1]);
axis image off
drawnow;
                   
end
