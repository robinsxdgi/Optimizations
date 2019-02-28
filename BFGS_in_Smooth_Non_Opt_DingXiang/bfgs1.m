%BFGS for function 1
function x_min = bfgs1(x0, H0, tolerance, max_iter)
    k = 1;
    x{1} = x0;
    H{1} = H0;
    I = eye(2,2);
    max_line_iter = 20;
    while norm(gf1(x{k}(1), x{k}(2))) > tolerance && k < max_iter
        log_df(k) = log(f1(x{k}(1), x{k}(2)) - 0);% Store the distance from f(x_k) to f*
        p{k} = - H{k} * gf1(x{k}(1), x{k}(2));
        alpha(k) = awline1(x{k}, p{k}, max_line_iter)
        if alpha(k) == -999
            break
        else
            x{k+1} = x{k} + alpha(k) * p{k};
            s{k} = alpha(k) * p{k};
            y{k} = gf1(x{k+1}(1), x{k+1}(2)) - gf1(x{k}(1), x{k}(2));
            H{k+1} = (I - (s{k} * y{k}') / (s{k}' * y{k}) ) * H{k} * (I - (y{k} * s{k}') / (s{k}' * y{k}) ) + (s{k} * s{k}') / (s{k}' * y{k});
            k = k + 1;
        end
    end
    x_min = x{k};
    plot([1:k-1],log_df)
    hold on
end