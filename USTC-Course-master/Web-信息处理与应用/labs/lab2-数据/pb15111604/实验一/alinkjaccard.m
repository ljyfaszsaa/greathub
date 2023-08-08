function [clustering] = alinkjaccard(A, k)
% ALINKJACCARD Average link agglomerative clustering with Jaccard similarity
%   
    % ������jaccard����.
    % Pairwise distance between pairs of observations
    Pdist = pdist(A,'jaccard');
    % Agglomerative hierarchical cluster tree
    % linkage(X,method)
    Link = linkage(Pdist, 'average'); 
    % Construct agglomerative clusters from linkages
    % cluster(Z,'maxclust',n)
    clustering = cluster(Link, 'maxclust', k); 
end
