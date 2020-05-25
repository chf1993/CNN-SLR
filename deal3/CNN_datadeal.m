%% 导入数据，整理为二维数组
%% 初始化
clc;clear;close all;
% add to path
this_dir = pwd;
addpath(genpath(this_dir));
xe='E:\研究生\盲人手势识别\测试56处理后\';%文件夹路径
A = dir(fullfile(xe,'*.txt'));%原文件所在文件夹
al=length(A);
%% 网络初始化
w=28;%确定数据维度
layer_c1_num=20;%卷积层
layer_s1_num=20;%池化层
layer_f1_num=100;%全连接层
layer_output_num=10;%输出层
n_num=20;
iternum=1;%网络训练次数
%权值调整步进
yita=0.01;
%bias初始化，偏差值
bias_c1=(2*rand(1,layer_c1_num)-ones(1,layer_c1_num))/sqrt(n_num);
bias_f1=(2*rand(1,layer_f1_num)-ones(1,layer_f1_num))/sqrt(n_num);
%卷积核初始化
[kernel_c1,kernel_f1]=init_kernel(layer_c1_num,layer_f1_num);
%pooling核初始化
pooling_a=ones(2,2)/4;
%全连接层的权值
weight_f1=(2*rand(20,100)-ones(20,100))/sqrt(20);
weight_output=(2*rand(100,10)-ones(100,10))/sqrt(100);
disp('网络初始化完成......');
%% 网络训练
h_w = waitbar(0,'开始网络训练......请稍候，处理中>>');
for t=1:al
    % t=1;%测试用
    %% 将原始数据整理为二维数组，以满足CNN数据源要求
    x=A(t).name;%单文件名
    [~, ~, ~, matches]=regexp(x,'\d+');
    m=str2double(matches{1});
    a=importdata([xe,x]);
    ax=[a(:,1);a(:,2);a(:,3)];
    ax=time1(ax,w*w);
        train_data=reshape(ax,w,w);

    %% 具体卷积过程
        for iter=1:iternum%多次训练网络以提高网络的识别率
    
    %前向传递,进入卷积层1
    for k=1:layer_c1_num
        state_c1(:,:,k)=convolution(train_data,kernel_c1(:,:,k));
        %进入激励函数
        state_c1(:,:,k)=tanh(state_c1(:,:,k)+bias_c1(1,k));
        %进入pooling1
        state_s1(:,:,k)=pooling(state_c1(:,:,k),pooling_a);
    end
    %进入f1层    
    [state_f1_pre,state_f1_temp]=convolution_f1(state_s1,kernel_f1,weight_f1);
    %进入激励函数
    for nn=1:layer_f1_num
        state_f1(1,nn)=tanh(state_f1_pre(:,:,nn)+bias_f1(1,nn));
    end
    %进入softmax层
    for nn=1:layer_output_num
        output(1,nn)=exp(state_f1*weight_output(:,nn))/sum(exp(state_f1*weight_output));
    end
    %% 误差计算部分
    Error_cost=-output(1,m+1);
    %         if (Error_cost<-0.98)%误差控制，筛选劣质数据
    %             break;
    %         end
    %% 参数调整部分
    [kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1]=CNN_upweight(yita,Error_cost,m,train_data,...
        state_c1,state_s1,...
        state_f1,state_f1_temp,...
        output,...
        kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1);
        end
    waitbar(t/al);
    
end
close(h_w);
%% 网络测试
disp('网络训练完成');
count=0;
h_w = waitbar(0,'开始检验......请稍候，处理中>>');

for t=1:al
    %读取样本
    
    % t=1;
    x=A(t).name;%单文件名
    [~, ~, ~, matches]=regexp(x,'\d+');
    m=str2double(matches{1});
    a=importdata([xe,x]);
    ax=[a(:,1);a(:,2);a(:,3)];
    ax=time1(ax,w*w);
    
    %% 具体卷积过程
    train_data=reshape(ax,w,w);
    
    for k=1:layer_c1_num
        state_c1(:,:,k)=convolution(train_data,kernel_c1(:,:,k));
        %进入激励函数
        state_c1(:,:,k)=tanh(state_c1(:,:,k)+bias_c1(1,k));
        %进入pooling1
        state_s1(:,:,k)=pooling(state_c1(:,:,k),pooling_a);
    end
    %进入f1层
    [state_f1_pre,state_f1_temp]=convolution_f1(state_s1,kernel_f1,weight_f1);
    %进入激励函数
    for nn=1:layer_f1_num
        state_f1(1,nn)=tanh(state_f1_pre(:,:,nn)+bias_f1(1,nn));
    end
    %进入softmax层
    for nn=1:layer_output_num
        output(1,nn)=exp(state_f1*weight_output(:,nn))/sum(exp(state_f1*weight_output));
    end
    [p,classify]=max(output);
    if (classify==m+1)
        count=count+1;
    end
    %     fprintf('真实数字为%d  网络标记为%d  概率值为%d \n',m,classify-1,p);
    waitbar(t/al);
    
end
close(h_w);
cc=count/(n_num*layer_output_num);
fprintf('正确率为%f',cc*100);