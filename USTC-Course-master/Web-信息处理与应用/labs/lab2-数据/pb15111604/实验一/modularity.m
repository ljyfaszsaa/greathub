function [ clustering ] = modularity( A, k )
%modularity Modularity maximization
%
    d = ( sum( A ) )';
    % sum of all.
    m = sum( d );
    B = A - d * d' / m;
    % ����ǰk����������.
    [ V, ~ ] = eigs( B, k );
    % kmeans
    clustering = kmeans( V, k );
end