function [ clustering ] = rcut( A, k )
%rcut Spectral clustering: ratio cut
%
    % D
    D = diag(sum(A));
    % ������˹,W = A
    L = D - A;
    % ����ǰk����С������������
    [V,~]= eigs(L, k, 'sm');
    % kmeans
    clustering = kmeans(V, k);
end