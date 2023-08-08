clc;clear;close all
%% ���ݵĶ���
data=xlsread('cumcm2012B����4_ɽ����ͬ������������ʱ���������������ǿ��.xls');
data1=data(:,3);%ˮƽ���ܷ���ǿ��
data2=data(:,4);%ˮƽ��ɢ�����ǿ��
data3=data1-data2;%ˮƽ����ֱ��ǿ��
hpi=40.1*pi/180;%��ͬ��γ��
%% ��������˵��
   
%phi�ǵ���γ�ȣ�beta�ǹ�����е���ǣ�deltaΪ̫����γ�ǣ�
%omegapΪˮƽ������ʱ�ǣ�romegatΪ��б������ʱ�ǡ�
%RbΪ��б���ϵ�ֱ�ӷ�������ˮƽ����ֱ�ӷ�����֮��
% Rb=(cos(hpi-beta).*cos(delta).*sin(omegat)+pi/180*sin(hpi-beta)sin(delta))./(cos(hpi)*cos(delta)*sin(omegap)+pi/180*omegap*sin(hpi)*sin(delta))
% delta=23.5*sin((2*pi*(284+n))/365)*pi/180;
% omegap=acos(-tan(hpi)*tan(delta));
% omegat=min(omegap,acos(-tan(hpi-beta)*tan(delta)));


%% �ܿ�����
   %ѡ��56��B3�ྦྷ���� ��һ��SN18�����
   % B3�Ĳ���U=33.6; I=8.33; �۸�12.5 �ߴ�1482*992 ת����15.98%
   % ������ļ۸� price2=54700  ���Ч��97.3%
n=1:365;
beta=38.1*pi/180;%��б��38.1
delta=23.5*sin((2*pi*(284+n))/365)*pi/180;
omegat=zeros(1,365);
omegap=zeros(1,365);

for i=1:365
    omegap(i)=acos(-tan(hpi)*tan(delta(i)));
    omegat(i)=min(omegap(i),acos(-tan(hpi-beta).*tan(delta(i))));
    Rb(i)=(cos(hpi-beta).*cos(delta(i)).*sin(omegat(i))+pi/180*sin(hpi-beta)*sin(delta(i)))./(cos(hpi)*cos(delta(i))*sin(omegap(i))+pi/180*omegap(i)*sin(hpi)*sin(delta(i)));
end
data4=zeros(365,1);
for i=1:365
    data4(24*i-23:24*i,1)=data3(24*i-23:24*i,1).*Rb(i)+(1+cos(beta)).*data2(24*i-23:24*i,1)/2+(1-cos(beta)).*data1(24*i-23:24*i,1)/2*0.25;
     
end
data5=data4;
data5(find(data5<80))=0;
 %�ݶ�������ÿ��ÿƽ�׵��ܹ���ǿ��
power1=sum(data5);

U=33.6; I=8.33;  %B3�ĵ�ѹ����
S=1.482*0.992; %B4�����
m=56; %�����ص���Ŀ
price1=m*12.5*U*I; %�����صķ���
price2=45700;%�����SN17�ķ���
g1=power1*S*m/1000*0.1598*0.973; %ÿ�������羭��Ч��


%% ������
disp('35���ܵķ�����')
G=g1*10+g1*15*0.9+g1*10*0.8
disp('����Ч��')
g=g1*0.5;  %������ÿ����������������Ч��
price=price1+price2; %�ɱ�����
%�����ûسɱ������
G*0.5-price
disp('�ûسɱ������')
if price/g<10
    nian=price/g
end
if (price/g>10)&(price/g<25)
    nian=(price-g*10)/(g*0.9)+10
else
    nian=(price-g*10-g*15*0.9)/(g*0.8)+25
end

    