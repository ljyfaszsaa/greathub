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


%% �����ݶ�
   %ѡ��36��B3�ྦྷ���� ������SN14�����
   % B3�Ĳ���U=33.6; I=8.33; �۸�12.5 �ߴ�1482*992 ת����15.98%
   % ������ļ۸� price2=15300   ���Ч��94%
n=1:365;
delta=23.5*sin((2*pi*(284+n))/365)*pi/180;
omegat=zeros(1,365);
omegap=zeros(1,365);
beta=acos(6400/6511.53);%��б��
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
 %�����ݶ�������ÿ��ÿƽ�׵��ܹ���ǿ��
power1=sum(data5);

U=33.6; I=8.33;  %B3�ĵ�ѹ����
S=1.482*0.992; %B4�����
m=36; %�����ص���Ŀ
price1=m*12.5*U*I; %�����صķ���
price2=15300*2;%�����SN14�ķ���
g1=power1*S*m/1000*0.1598*0.94; %ÿ�������羭��Ч��
%% �����ݶ�
%ѡC1 SN12 
   %ѡ��9��C1�ྦྷ���� ��һ��SN12�����
   % C1�Ĳ���U=138; I=1.22; �۸�12.5 �ߴ�1300*1100 ת����6.99%
   % ������ļ۸� 6900   ���Ч��94%
   
beta=acos(700/1389.24);%��б��
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
data5(find(data5<30))=0;
%�����ݶ�������ÿ��ÿƽ�׵��ܹ���ǿ��
power2=sum(data5);

n=9;
U1=138; I1=1.22;  %B3�ĵ�ѹ����
S=1.300*1.100;
price3=n*4.8*U1*I1;%�����صĳɱ�����
price4=6900;    %SN12������ķ���

g2=power2*S*n*0.0635/1000*0.94;%�����ݶ�������ÿ��������������

%% ������
g1+g2;
g=(g1+g2)*0.5;  %������ÿ����������������Ч��
price=price1+price2+price3+price4; %�ɱ�����
G=g*10+g*15*0.9+g*10*0.8;
disp('35���ܵķ�����')
 G/0.5
disp('35��ľ���Ч��')
 G-price

%�����ûسɱ������
disp('�ûسɱ������')
if price/g<10
    nian=price/g
end
if (price/g>10)&(price/g<25)
    nian=(price-g*10)/(g*0.9)+10
else
    nian=(price-g*10-g*15*0.9)/(g*0.8)+25
end

    