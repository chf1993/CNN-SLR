function m=tainn_BPNN(a1,a2,a3)
%������ȡѵ������
a1=smooth(a1);a2=smooth(a2);a3=smooth(a3);%�˲�

a1=(a1-min(a1))/(max(a1)-min(a1));a2=(a2-min(a2))/(max(a2)-min(a2));a3=(a3-min(a3))/(max(a3)-min(a3));%��һ��
a1=time1(a1,500);a2=time1(a2,500);a3=time1(a3,500);

[a1,a2,a3]=allgr3(a1,a2,a3);%��ֹ���ȡ
a1=time1(a1,300);a2=time1(a2,300);a3=time1(a3,300);
%c1=aryule(a1,6);c2=aryule(a2,6);c3=aryule(a3,6);     %�Իع�
[f1,~] = ksdensity(a1);[f2,~] = ksdensity(a2);[f3,~] = ksdensity(a3);%�����ܶȺ���

t=1;
m(t,1)=max(diff(a1));m(t,2)=max(diff(a2));m(t,3)=max(diff(a3));%2�����

t=2;
%m(t,1)=c1(7);m(t,2)=c2(7);m(t,3)=c3(7);%5 �Իع�ϵ��7
m(t,1)=mean(a1);m(t,2)=mean(a2);m(t,3)=mean(a3);%1��ֵ

t=3;
%m(t,1)=c1(2);m(t,2)=c2(2);m(t,3)=c3(2);%9 �Իع�ϵ��2
m(t,1)=mean(f1);m(t,2)=mean(f2);m(t,3)=mean(f3);%3ƽ�������ܶ�f

t=4;
%[~,m(t,1)]=find(a1==max(a1), 1 );[~,m(t,2)]=find(a2==max(a2), 1 );[~,m(t,3)]=find(a3==max(a3), 1 );%6���ֵ����λ��
m(t,1)=median(a1);m(t,2)=median(a2);m(t,3)=median(a3);%4��ֵ

t=6;
[~,m(t,1)]=find(a1==min(a1), 1 );[~,m(t,2)]=find(a2==min(a2), 1 );[~,m(t,3)]=find(a3==min(a3), 1 );%7��Сֵ����λ��;

t=7;
m(t,1)=std(a1); m(t,2)=std(a2); m(t,3)=std(a3);%10����
