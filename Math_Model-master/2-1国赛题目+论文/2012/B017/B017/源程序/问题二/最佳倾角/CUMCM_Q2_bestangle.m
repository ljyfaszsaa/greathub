function f=myfun(x)
%�������
day=xlsread('data.xls',1,'B2:B8761');
%ˮƽ���ܷ���ǿ��
H=xlsread('data.xls',1,'E2:E8761');
%ˮƽ��ɢ�����ǿ��
Hd=xlsread('data.xls',1,'F2:F8761');
%����ֱ�����ǿ�ȣ���sina����Hb
Hb_sina=xlsread('data.xls',1,'G2:G8761');
%��γ��
sigma=xlsread('data.xls',1,'H2:H8761');
%ʱ��
w=xlsread('data.xls',1,'I2:I8761');
%����γ��
weidu=40.1;
%̫���߶Ƚ�a��sinֵ
sina=xlsread('data.xls',1,'K2:K8761');
%ˮƽ������ʱ�ǣ����ȱ�ʾ
wh=xlsread('data.xls',1,'M2:M8761');
%��б������ʱ�ǣ����ȱ�ʾ
ws=xlsread('data.xls',1,'N2:N8761');
Ho=xlsread('data.xls',1,'Q2:Q8761');
P=0.08;
PI=3.1416;
rad=2*PI/360;
result=0;
for k=1:8760
    r=(cos(rad*(weidu-x))*cos(rad*sigma(k,1))*sin(ws(k,1))+ws(k,1)*sin(rad*(weidu-x))*sin(rad*sigma(k,1)))/(cos(rad*(weidu))*cos(rad*sigma(k,1))*sin(wh(k,1))+wh(k,1)*sin(rad*(weidu))*sin(rad*sigma(k,1)));
    Hb=Hb_sina(k,1)*sina(k,1);
    t=Hb*r+Hd(k,1)*((Hb/Ho(k,1))*r+0.5*(1-(Hb/Ho(k,1)))*(1+cos(rad*x)))+0.5*P*H(k,1)*(1-cos(rad*x));
	%����ͷ�������ֵ�Ƚ�
    if(t>=200)
        result=result+t;
    end
end
f=-result;


