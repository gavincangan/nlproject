clear; close all;

iter_count = 1200;

N = 400;
dim = 5;
k = 5;

min_g = 0;
max_g = 7;
g_steps = 0.05;

rand_min = -1;
rand_max = 1;

num_g_steps = round( (max_g - min_g) / g_steps ) + 1;

g_array = min_g:g_steps:max_g;

J = (rand_max - rand_min) .* rand(N,2*k+1,dim) + rand_min;

S_init = (rand_max - rand_min) .* rand(N,dim) + rand_min;

x = 1:N;

figure(1);
hold on;

colors = zeros(num_g_steps, 3);
blues = (0:num_g_steps-1) ./ (num_g_steps-1);
greens = fliplr(blues);
colors(:, 2) = greens';
colors(:, 3) = blues';

colors = colors.^2;

g = 0.47;
iter_g = 1;
% for g=min_g:g_steps:max_g
    S = S_init;
    sigma = zeros(iter_count,1);
    for iter_indx = 1:iter_count
        S_old = S;
        for indx = 1:N
            nbor_sum = zeros(dim, 1);
            for nbor_indx = -k:k
    %             disp('a')
    %             rem(indx + nbor_indx + N, N) + 1
    %             disp('b')
    %             4 + nbor_indx
                elemnt = S_old( rem(indx + nbor_indx + N, N) + 1 , : );
                coeff = J( indx, k + nbor_indx + 1, :);
                temp_sum =  reshape(elemnt, [dim, 1]) .* reshape(coeff,[dim, 1]);
                nbor_sum = nbor_sum + (temp_sum);
            end
            nbor_sum = nbor_sum .* g;
            S(indx, :) = tanh(nbor_sum);
        end
        tsigma = (sum(sum((S_init - S).^2))/N);
        sigma(iter_indx,1) = tsigma;
    end
    plot(sigma, 'color',colors(iter_g, :) );
    iter_g = iter_g + 1;
% end

% if(g<=max_g)
%     g = g + g_step;
% end

hdl = gcf;


disp('done');
