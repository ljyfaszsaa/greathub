
%%%%%%%%%%%%%%%%ÿ��Ĺ���ǿ��%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%������Ϊ��%%%%%%%%%%%%%%%%%%%
clear all
clc
alpha00=1:1:90;
alpha0=alpha00*pi/180;
n0=length(alpha0);
fai=40.1*pi/180;%γ��
gama=0*pi/180;%���ݷ�λ��
Isc=1353;
AA=xlsread('������.xlsx');
n=length(AA(:,1));
I_b01=AA(:,4)-AA(:,5);
I_d01=AA(:,5);
I_b0=zeros(365,1);
I_d0=zeros(365,1);
for i=1:365
for j=1:24
    I_b0(i)=I_b0(i)+I_b01((i-1)*24+j);
    I_d0(i)=I_d0(i)+I_d01((i-1)*24+j);
end
end
for ii=1:n0
    ii
%alpha=10*pi/180;%б��ƫ��
alpha=alpha0(ii);
for i=1:365    

   deta(i)=pi/180*23.45*sin((2*pi*(284+i))/365);%
   w0(i)=acos(-tan(fai)*tan(deta(i)));%ˮƽ��������ʱ
   I0(i)=24/pi*Isc*(1+0.033*cos(360*i/365))*(cos(fai)*cos(deta(i))*sin(w0(i))+2*pi*w0(i)/360*sin(fai)*sin(deta(i)));%
   %%%������ˮƽ��̫������ǿ��
   w(i)=0;
   k=i;
    C_theta(k)=(sin(fai)*cos(alpha)-cos(fai)*sin(alpha)*cos(gama))*sin(deta(k))+(cos(fai)*cos(alpha)+sin(fai)*sin(alpha)*cos(gama))*cos(deta(k))*cos(w(k))+sin(alpha)*sin(gama)*cos(deta(k))*sin(w(k));
    C_theta0(k)=sin(fai)*sin(deta(k))+cos(fai)*cos(deta(k))*cos(w(k));
    I_b(k)=I_b0(k)*(C_theta(k)/C_theta0(k));   
    I_d(k)=I_d0(k)*(I_b0(k)*(C_theta(k)/C_theta0(k))/I0(k)+0.5*(1-I_b0(k)/I0(k))*(1+cos(alpha)));
    I(k)=I_b(k)+I_d(k);
end
w=w'*pi/180;%ʱ��
   deta=deta';%��γ��
   

BB=[31,28,31,30,31,30,31,31,30,31,30,31];
CC=[0,31,59,90,120,151,181,212,243,273,304,334];
I_m=zeros(12,1);
for i=1:12
    for j=1:BB(i)
        I_m(i)=I_m(i)+I(CC(i)+j);
    end
end
II_m(:,ii)=I_m;
end
II_m=II_m';
plot(alpha00,II_m);


    