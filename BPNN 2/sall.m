%% ����ʶ����������Ϊԭʼ����
%ʹ��train�ļ��������к���
clc;clear;close all;
% add to path
this_dir = pwd;
addpath(genpath(this_dir));
dall()%ɾ�������ļ�
xe='E:\�о���\ä������ʶ��\���ݲɼ�\20180111\';%������Դ����Ҫ��������Դ�ļ�λ�ø��ģ�
tez(xe)%������ֵ
te_lv=0.5;%����������ռ�ı���
n=ttain(te_lv);%�����ļ�,nΪ�����ڵ�
%��ȡѵ������
load 'taindata\tain1.txt'
%% ����ֵ��һ��
[input,PS] = mapminmax( tain1');%���������д���
%% �����������
[s,c]=size(tain1);%sΪ������cΪ����
T=zeros(1,1);%Ŀ������
% classes_full=['0' ;'1'; '2' ;'6'; '7'];
for i =1:s
    T(tain1(i,c),i  ) = 1 ;
end
%% ����������
P=input(1:end-1,:);%��������
m=size(P,1);%�����ڵ�
S=floor((n+m)^0.5+6);%������ڵ�
% net = newff( minmax(input) , [S n] , { 'logsig' 'purelin'} , 'traingdx');%�ɰ��÷�
net=newff(P ,T, S, {'tansig', 'purelin'}, 'traingd');%�°��÷�
net=init(net);%��ʼ��������
%����ѵ������
net.trainparam.epochs = 5000 ;%ѵ��������Ĭ��1000
net.trainparam.goal = 0.001 ;%ѵ��Ŀ�꣬Ĭ��0
net.trainParam.lr = 0.01 ;%ѧϰ��
net.trainParam.showWindow = 0;%���ʾ��ͼ�Ƿ���ʾ��Ĭ��Ϊ1/ture����ʾ��
%% ������ѵ�����������£�
% net.trainFcn ='traingd'; % �ݶ��½��㷨
% net.trainFcn ='traingdm'; % �����ݶ��½��㷨
% net.trainFcn ='traingda'; % ��ѧϰ���ݶ��½��㷨
% net.trainFcn ='traingdx'; % ��ѧϰ�ʶ����ݶ��½��㷨
% (����������Ƽ��㷨)
% net.trainFcn ='trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
% (�����ݶ��㷨)
% net.trainFcn ='traincgf'; % Fletcher-Reeves�����㷨
% net.trainFcn ='traincgp'; % Polak-Ribiere�����㷨,�ڴ������Fletcher-Reeves�����㷨�Դ�
% net.trainFcn ='traincgb'; % Powell-Beal��λ�㷨,�ڴ������Polak-Ribiere�����㷨�Դ�
% (����������Ƽ��㷨)
%net.trainFcn ='trainscg'; % Scaled ConjugateGradient�㷨,�ڴ�������Fletcher-Reeves�����㷨��ͬ,�����������������㷨��С�ܶ�
% net.trainFcn ='trainbfg'; % Quasi-NewtonAlgorithms - BFGS Algorithm,���������ڴ�������ȹ����ݶ��㷨��,�������ȽϿ�
% net.trainFcn ='trainoss'; % One Step SecantAlgorithm,���������ڴ��������BFGS�㷨С,�ȹ����ݶ��㷨�Դ�
% (����������Ƽ��㷨)
%net.trainFcn ='trainlm'; % Levenberg-Marquardt�㷨,�ڴ�����ϴ�,�����ٶ����
% net.trainFcn ='trainbr'; % ��Ҷ˹�����㷨
% �д����Ե������㷨Ϊ:'traingdx','trainrp','trainscg','trainoss','trainlm'
%% ��ʼѵ��
net = train( net, P, T ) ;
%% ��ȡ��������
load 'taindata\t1.txt'
[~,c1]=size(t1);
%% �������ݹ�һ��
testInput = mapminmax('apply',t1',PS);
%% ����
testInput(end,:)=[];
Y = sim( net , testInput );
%% ͳ��ʶ����ȷ��
[~ , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [~ , Index] = max( Y( : ,  i ) ) ;
    if( Index  == t1(i,c1))
        hitNum = hitNum + 1 ;
    end
end
sprintf('ʶ������ %3.3f%%',100 * hitNum / s2 )
msgbox(['ʶ������',num2str(100 * hitNum / s2 ),'%'], 'ʶ����');
clear ans c c1 i Index input m output s s1 s2 t1 tain1 xe n P T testInput Y this_dir S
save('net_a')