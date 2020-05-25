%% �������ݣ�����Ϊ��ά����
%% ��ʼ��
clc;clear;close all;
% add to path
this_dir = pwd;
addpath(genpath(this_dir));
xe='E:\�о���\ä������ʶ��\����56�����\';%�ļ���·��
A = dir(fullfile(xe,'*.txt'));%ԭ�ļ������ļ���
al=length(A);
%% �����ʼ��
w=28;%ȷ������ά��
layer_c1_num=20;%�����
layer_s1_num=20;%�ػ���
layer_f1_num=100;%ȫ���Ӳ�
layer_output_num=10;%�����
n_num=20;
iternum=1;%����ѵ������
%Ȩֵ��������
yita=0.01;
%bias��ʼ����ƫ��ֵ
bias_c1=(2*rand(1,layer_c1_num)-ones(1,layer_c1_num))/sqrt(n_num);
bias_f1=(2*rand(1,layer_f1_num)-ones(1,layer_f1_num))/sqrt(n_num);
%����˳�ʼ��
[kernel_c1,kernel_f1]=init_kernel(layer_c1_num,layer_f1_num);
%pooling�˳�ʼ��
pooling_a=ones(2,2)/4;
%ȫ���Ӳ��Ȩֵ
weight_f1=(2*rand(20,100)-ones(20,100))/sqrt(20);
weight_output=(2*rand(100,10)-ones(100,10))/sqrt(100);
disp('�����ʼ�����......');
%% ����ѵ��
h_w = waitbar(0,'��ʼ����ѵ��......���Ժ򣬴�����>>');
for t=1:al
    % t=1;%������
    %% ��ԭʼ��������Ϊ��ά���飬������CNN����ԴҪ��
    x=A(t).name;%���ļ���
    [~, ~, ~, matches]=regexp(x,'\d+');
    m=str2double(matches{1});
    a=importdata([xe,x]);
    ax=[a(:,1);a(:,2);a(:,3)];
    ax=time1(ax,w*w);
        train_data=reshape(ax,w,w);

    %% ����������
        for iter=1:iternum%���ѵ����������������ʶ����
    
    %ǰ�򴫵�,��������1
    for k=1:layer_c1_num
        state_c1(:,:,k)=convolution(train_data,kernel_c1(:,:,k));
        %���뼤������
        state_c1(:,:,k)=tanh(state_c1(:,:,k)+bias_c1(1,k));
        %����pooling1
        state_s1(:,:,k)=pooling(state_c1(:,:,k),pooling_a);
    end
    %����f1��    
    [state_f1_pre,state_f1_temp]=convolution_f1(state_s1,kernel_f1,weight_f1);
    %���뼤������
    for nn=1:layer_f1_num
        state_f1(1,nn)=tanh(state_f1_pre(:,:,nn)+bias_f1(1,nn));
    end
    %����softmax��
    for nn=1:layer_output_num
        output(1,nn)=exp(state_f1*weight_output(:,nn))/sum(exp(state_f1*weight_output));
    end
    %% �����㲿��
    Error_cost=-output(1,m+1);
    %         if (Error_cost<-0.98)%�����ƣ�ɸѡ��������
    %             break;
    %         end
    %% ������������
    [kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1]=CNN_upweight(yita,Error_cost,m,train_data,...
        state_c1,state_s1,...
        state_f1,state_f1_temp,...
        output,...
        kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1);
        end
    waitbar(t/al);
    
end
close(h_w);
%% �������
disp('����ѵ�����');
count=0;
h_w = waitbar(0,'��ʼ����......���Ժ򣬴�����>>');

for t=1:al
    %��ȡ����
    
    % t=1;
    x=A(t).name;%���ļ���
    [~, ~, ~, matches]=regexp(x,'\d+');
    m=str2double(matches{1});
    a=importdata([xe,x]);
    ax=[a(:,1);a(:,2);a(:,3)];
    ax=time1(ax,w*w);
    
    %% ����������
    train_data=reshape(ax,w,w);
    
    for k=1:layer_c1_num
        state_c1(:,:,k)=convolution(train_data,kernel_c1(:,:,k));
        %���뼤������
        state_c1(:,:,k)=tanh(state_c1(:,:,k)+bias_c1(1,k));
        %����pooling1
        state_s1(:,:,k)=pooling(state_c1(:,:,k),pooling_a);
    end
    %����f1��
    [state_f1_pre,state_f1_temp]=convolution_f1(state_s1,kernel_f1,weight_f1);
    %���뼤������
    for nn=1:layer_f1_num
        state_f1(1,nn)=tanh(state_f1_pre(:,:,nn)+bias_f1(1,nn));
    end
    %����softmax��
    for nn=1:layer_output_num
        output(1,nn)=exp(state_f1*weight_output(:,nn))/sum(exp(state_f1*weight_output));
    end
    [p,classify]=max(output);
    if (classify==m+1)
        count=count+1;
    end
    %     fprintf('��ʵ����Ϊ%d  ������Ϊ%d  ����ֵΪ%d \n',m,classify-1,p);
    waitbar(t/al);
    
end
close(h_w);
cc=count/(n_num*layer_output_num);
fprintf('��ȷ��Ϊ%f',cc*100);