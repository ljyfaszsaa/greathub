clear;clc
fushe=xlsread('cumcm.xls','sheet','E4:M8763');
dianban=xlsread('cumcm.xls','sheet1','B1:F24');
tz_zs=fushe(:,1)-fushe(:,2);
%nx_zs=fushe(:,5)-0.5*fushe(:,2);
thta=59.76/57.3;
sa=sin(thta);ca=cos(thta);
fushe_renyi=tz_zs*ca+fushe(:,2)*(pi-thta)/pi;
P=52.5;%��������
p0=30;%���ǿ�ȣ�������ྦྷ��Ϊ80����ĤΪ30
for i=1:8760
    for j=1:9
        if fushe(i,j)<p0
            fushe(i,j)=0;
        end
    end
end
%for i=1:8760%���������Ҫ���������ֲ�Ҫ
%    for j=1:9
%        if fushe(i,j)<200
%            fushe(i,j)=fushe(i,j)*0.05;
%        end
%    end
%end
Q=sum(fushe*P/1000)/1000;

