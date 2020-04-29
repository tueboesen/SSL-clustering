function [A,dd] = getAdjacencyMatrix(data,nn)
%Finds the exact adjacency matrix. This should only be used on small
%datasets. For larger datasets use one of the methods here:
%https://github.com/erikbern/ann-benchmarks
%different methods are suited for different datasets.
data = data';
n = size(data,2);
I = zeros((nn+1),n); 
J = zeros((nn+1),n);

dd = zeros(n,nn+1);
for i=1:n
    r = data - data(:,i);    
    d = sum(r.*r,1);

    [di,idx] = sort(d);
    I(:,i) = i*ones(nn+1,1);
    J(:,i) = idx(1:nn+1);    
    dd(i,:) = di(1:nn+1)';
end


A = sparse(I(:),J(:),ones(length(J(:)),1),n,n);
A = sign(A+A');
    