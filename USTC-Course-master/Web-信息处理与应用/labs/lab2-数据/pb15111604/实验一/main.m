% polbooks����.
load( 'polbooks.mat' );
% ����alinkjaccard
outcome = alinkjaccard( A, k );
% ������д�뵽 ASCII �ָ��ļ�
dlmwrite( 'output/polbooks_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% ����gn
outcome = girvannewman( A, k );
dlmwrite( 'output/polbooks_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% ����rcut
outcome = rcut( A, k );
dlmwrite( 'output/polbooks_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% ����ncut
outcome = ncut( A, k );
dlmwrite( 'output/polbooks_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
% ����modularity
outcome = modularity( A, k );
dlmwrite( 'output/polbooks_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% football����.
load( 'football.mat' );
outcome = alinkjaccard( A, k );
dlmwrite( 'output/football_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = girvannewman( A, k );
dlmwrite( 'output/football_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = rcut( A, k );
dlmwrite( 'output/football_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = ncut( A, k );
dlmwrite( 'output/football_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = modularity( A, k );
dlmwrite( 'output/football_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% DBLP����.
load( 'DBLP.mat' );
outcome = alinkjaccard( A, k );
dlmwrite( 'output/DBLP_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = rcut( A, k );
dlmwrite( 'output/DBLP_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = ncut( A, k );
dlmwrite( 'output/DBLP_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = modularity( A, k );
dlmwrite( 'output/DBLP_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% Egonet����.
load( 'Egonet.mat' );
k = 18;
outcome = alinkjaccard( x, k );
dlmwrite( 'output/Egonet_alinkjaccard.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = rcut( x, k );
dlmwrite( 'output/Egonet_rcut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = ncut( x, k );
dlmwrite( 'output/Egonet_ncut.txt', outcome, 'precision', '%d', 'newline', 'pc' );
outcome = modularity( x, k );
dlmwrite( 'output/Egonet_modularity.txt', outcome, 'precision', '%d', 'newline', 'pc' );

% ������ͷ��������.
load( 'DBLP.mat' );
outcome = girvannewman( A, k );
dlmwrite( 'output/DBLP_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );
load( 'Egonet.mat' );
k = 18;
outcome = girvannewman( x, k );
dlmwrite( 'output/Egonet_girvannewman.txt', outcome, 'precision', '%d', 'newline', 'pc' );