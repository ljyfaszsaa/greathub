function graph = getMatrix(s)
%GETMATRIX ��graph.txt�õ�����.
%   
    % ����
    r = importdata('graph.txt');
    % ����
    nodes = r(1);
    % ɾȥ��һ�в�������
    r(1,:)=[];
    % ���ǵ�txt�нڵ��0��ʼ,+1
    i = r(:, 1)' + 1;
    j = r(:, 2)' + 1;
    p = r(:, 3)';
    graph = full(sparse(i, j, p));
    graph = [graph; zeros(1, nodes)];
end
