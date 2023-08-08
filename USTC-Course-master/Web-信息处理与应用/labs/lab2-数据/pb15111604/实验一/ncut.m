function [ clustering ] = ncut( A, k )
%ncut Spectral clustering: normalized cut
%
    % D
    D = full(diag(sum(A)));
    % ������˹,W = A
    L = D - A;
    % ��Ӧncut.
    L = D^(-1/2) * L * D^(-1/2);
    % ����ǰk����С������������
    [V,~]= eigs(L, k, 'sm');
    % kmeans
    clustering = kmeans(V, k);
end