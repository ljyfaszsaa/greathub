% ÿƽ�����Լ۱�
clear,clc
%% ��������
data=xlsread('cumcm2012B_����3_�������͵Ĺ�����(A������B�ྦྷ��C�Ǿ��象Ĥ)�����Ʋ������г��۸�.xls');
pice=[14.9 12.5 4.8];
long=data(:,2);%��
wide=data(:,3);%��
U=data(:,4);%��ѹ
I=data(:,5);%����
eta=data(:,6);%ת����
P=U.*I;
S=long.*wide/1000;
%% ÿƽ�׼۸�
for i=1:6
    p1(i)=P(i)*pice(1)/S(i);
  
end %A������
for i=7:13
          p1(i)=P(i)*pice(2)/S(i);
end  %B�ྦྷ��
for i=14:24
  p1(i)=P(i)*pice(3)/S(i);
end  %C�Ǿ��象Ĥ
%% ÿƽ�����Լ۱�
ratio=eta./p1';
plot(1:6,ratio(1:6),'k-*')
hold on
plot(7:13,ratio(7:13),'k-s')
hold on
plot(14:24,ratio(14:24),'k-d')
text()

set(gca,'xtick',[0:1:24])