function [time,iteration] = Jacobi(A,n,b,x0,tol,itMax)
% Jacobi Method for solving linear systems
% Inputs: 
% matrix A, vector b, dimension of matrix n, initial solution x0, tolerance tol, and max iterations allowed itMax
% Outputs:
% time and iterations it takes to arrive at solution within certain tolerance
it = 0;
xOld = x0;
tic
while it < itMax
    xNew(1) = (b(1) - A(1,2:n)*xOld(2:n))/A(1,1);
    for i = 2:n-1
       xNew(i) = (b(i) - A(i,1:i-1)*(xOld(1:i-1)) ...
           -A(i,i+1:n)*xOld(i+1:n))/A(i,i);
    end
    xNew(n) = (b(n) - A(n,1:n-1)*(xOld(1:n-1)))/A(n,n);
    xNewJac = transpose(xNew);
    delta = xNewJac - xOld;
    deltaNorm = norm(delta);
    xNorm = norm(xNew);
    if (deltaNorm < tol*xNorm)
        display(['Jacobi solution converged in ' num2str(it) ' iterations']);
        iteration = it;
        xApprox = xNewJac;
        %display(xApprox)
        time = toc;
        return
    end
    xOld = xNewJac;
    it = it+1;
end
error(['Convergence in ' num2str(itMax) ' iterations failed'])
