function Y=SSL_clustering(L,alpha,beta,Yobs,W);
%Performs the constrained clustering
nk = trace(W);
[n,nc] = size(Yobs);
e = ones(nc,1);
I_nc = eye(nc);
C = I_nc - (e*e')./(e'*e);
TOL = 1e-12;
MAXIT = 2000;
A = (1/n*alpha*L +beta*speye(n) +1/nk* W);
b = 1/nk*W*Yobs*C;
M = @(x) tril(A)\(diag(A).*(triu(A)\x));
tic
for ii = 1:nc-1
    Y(:,ii) = pcg(A,b(:,ii),TOL,MAXIT,M);
end
Y(:,nc) = -sum(Y(:,1:nc-1),2); %We can skip the last calculation, since we know that from the constraint

end