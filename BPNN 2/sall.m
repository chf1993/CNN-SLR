%% 整体识别函数，输入为原始数据
%使用train文件夹内所有函数
clc;clear;close all;
% add to path
this_dir = pwd;
addpath(genpath(this_dir));
dall()%删除早期文件
xe='E:\研究生\盲人手势识别\数据采集\20180111\';%数据来源（需要根据数据源文件位置更改）
tez(xe)%求特征值
te_lv=0.5;%测试数据所占的比例
n=ttain(te_lv);%保存文件,n为输出层节点
%读取训练数据
load 'taindata\tain1.txt'
%% 特征值归一化
[input,PS] = mapminmax( tain1');%按照行逐行处理
%% 构造输出矩阵
[s,c]=size(tain1);%s为列数，c为行数
T=zeros(1,1);%目标向量
% classes_full=['0' ;'1'; '2' ;'6'; '7'];
for i =1:s
    T(tain1(i,c),i  ) = 1 ;
end
%% 创建神经网络
P=input(1:end-1,:);%输入向量
m=size(P,1);%输入层节点
S=floor((n+m)^0.5+6);%隐含层节点
% net = newff( minmax(input) , [S n] , { 'logsig' 'purelin'} , 'traingdx');%旧版用法
net=newff(P ,T, S, {'tansig', 'purelin'}, 'traingd');%新版用法
net=init(net);%初始化神经网络
%设置训练参数
net.trainparam.epochs = 5000 ;%训练次数，默认1000
net.trainparam.goal = 0.001 ;%训练目标，默认0
net.trainParam.lr = 0.01 ;%学习率
net.trainParam.showWindow = 0;%结果示意图是否显示，默认为1/ture（显示）
%% 其它的训练函数有如下：
% net.trainFcn ='traingd'; % 梯度下降算法
% net.trainFcn ='traingdm'; % 动量梯度下降算法
% net.trainFcn ='traingda'; % 变学习率梯度下降算法
% net.trainFcn ='traingdx'; % 变学习率动量梯度下降算法
% (大型网络的推荐算法)
% net.trainFcn ='trainrp'; % RPROP(弹性BP)算法,内存需求最小
% (共轭梯度算法)
% net.trainFcn ='traincgf'; % Fletcher-Reeves修正算法
% net.trainFcn ='traincgp'; % Polak-Ribiere修正算法,内存需求比Fletcher-Reeves修正算法略大
% net.trainFcn ='traincgb'; % Powell-Beal复位算法,内存需求比Polak-Ribiere修正算法略大
% (大型网络的推荐算法)
%net.trainFcn ='trainscg'; % Scaled ConjugateGradient算法,内存需求与Fletcher-Reeves修正算法相同,计算量比上面三种算法都小很多
% net.trainFcn ='trainbfg'; % Quasi-NewtonAlgorithms - BFGS Algorithm,计算量和内存需求均比共轭梯度算法大,但收敛比较快
% net.trainFcn ='trainoss'; % One Step SecantAlgorithm,计算量和内存需求均比BFGS算法小,比共轭梯度算法略大
% (中型网络的推荐算法)
%net.trainFcn ='trainlm'; % Levenberg-Marquardt算法,内存需求较大,收敛速度最快
% net.trainFcn ='trainbr'; % 贝叶斯正则化算法
% 有代表性的五种算法为:'traingdx','trainrp','trainscg','trainoss','trainlm'
%% 开始训练
net = train( net, P, T ) ;
%% 读取测试数据
load 'taindata\t1.txt'
[~,c1]=size(t1);
%% 测试数据归一化
testInput = mapminmax('apply',t1',PS);
%% 仿真
testInput(end,:)=[];
Y = sim( net , testInput );
%% 统计识别正确率
[~ , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [~ , Index] = max( Y( : ,  i ) ) ;
    if( Index  == t1(i,c1))
        hitNum = hitNum + 1 ;
    end
end
sprintf('识别率是 %3.3f%%',100 * hitNum / s2 )
msgbox(['识别率是',num2str(100 * hitNum / s2 ),'%'], '识别率');
clear ans c c1 i Index input m output s s1 s2 t1 tain1 xe n P T testInput Y this_dir S
save('net_a')