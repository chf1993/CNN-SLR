%% �����Untitled_tezheng��ʹ��ѭ����ȡ����
%feature extraction������ȡ
function m=feature_extraction()
xc='E:\�о���\ä������ʶ��\���ݲɼ�\20180111\';
A=dir(fullfile(xc,'*.txt'));
a_long=length(A);
m={};f={};c={};az={};%cell�����ʼ����������ڣ�������ܱ���
for t=1:a_long
    %��������
    xe=A(t).name;
    ax=importdata([xc,xe]);
    a1=ax(:,1);a2=ax(:,2);a3=ax(:,3);
    %Ԥ����
    a1=smooth(a1);a2=smooth(a2);a3=smooth(a3);%�˲�
    a1=(a1-min(a1))/(max(a1)-min(a1));a2=(a2-min(a2))/(max(a2)-min(a2));a3=(a3-min(a3))/(max(a3)-min(a3));%��һ��
    a1=time1(a1,500);a2=time1(a2,500);a3=time1(a3,500);
    [a1,a2,a3]=allgr3(a1,a2,a3);%��ֹ���ȡ
    a1=time1(a1,300);a2=time1(a2,300);a3=time1(a3,300);
    ain(:,1)=a1;ain(:,2)=a2;ain(:,3)=a3;
    [f{1},~] = ksdensity(a1);[f{2},~] = ksdensity(a2);[f{3},~] = ksdensity(a3);%�����ܶȺ���
    c{1}(t,:)=aryule(a1,6);c{2}(t,:)=aryule(a2,6);c{3}(t,:)=aryule(a3,6);%�Իع�(��)
    az{1}=autocorr(a1,a_long-1);az{2}=autocorr(a2,a_long-1);az{3}=autocorr(a3,a_long-1);%�����
    %��������
    for i=1:3
        a1=ain(:,i);
        fii=f{i};%��������ܶȺ���
        ci=c{i};%�����Իع�
        azi=az{i};%���������
        %�������
        m{1}(t,i)=mean(a1);%1��ֵ
        m{2}(t,i)=max(diff(a1));%2�����
        m{3}(t,i)=mean(fii);%3ƽ�������ܶ�f
        m{4}(t,i)=median(a1);%4��ֵ
        m{5}(t,i)=ci(t,7);%5 �Իع�ϵ��7
        m{6}(t,i)=find(a1==max(a1),1);%6���ֵ����λ��
        m{7}(t,i)=find(a1==min(a1),1);%7��Сֵ����λ��
        m{8}(t,i)=std(fii);%8��������ܶ�f
        m{9}(t,i)=ci(t,2);%9 �Իع�ϵ��2
        m{10}(t,i)=std(a1);%10����
        m{11}(t,i)=ci(t,3);%11 �Իع�ϵ��3
        m{12}(t,i)=ci(t,4);%12 �Իع�ϵ��4
        m{13}(t,i)=max(fii);%13�������ܶ�f
        m{14}(t,i)=ci(t,5);%14 �Իع�ϵ��5
        m{15}(t,i)=ci(t,6);%15 �Իع�ϵ��6
        m{16}(t,i)=mean(azi);%16�����ƽ��ֵ
        m{17}(t,i)=min(azi);%17�������Сֵ
        m{18}(t,i)=max(diff(azi)); %18��������
        m{19}(t,i)=std(azi);%19����ط���
        m{20}(t,i)=max(diff(a1));%20�����(����)
        m{21}(t,i)=min(diff(a1));%21��С����(����)
        clear fi ci a1
    end
    clear xe ax
end
clear t A matches
