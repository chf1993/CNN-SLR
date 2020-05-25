%%%  matlabʵ��LeNet-5
%%%  ���ߣ�xd.wp
%%%  ʱ�䣺2016.10.22  14:29
%% ����˵��
%          1���ػ���pooling������ƽ��2*2
%          2����������˵����
%                           ����㣺28*28
%                           ��һ�㣺24*24�������*20
%                           tanh
%                           �ڶ��㣺12*12��pooling��*20
%                           �����㣺100(ȫ����)
%                           ���Ĳ㣺10(softmax)
%          3������ѵ�����ֲ���800�����������鲿�ֲ���100������
clc;clear;close all;
%this_dir = pwd;
% addpath(genpath(this_dir));
%% �����ʼ��
layer_c1_num=20;%�����
layer_s1_num=20;%�ػ���
layer_f1_num=100;%ȫ���Ӳ�
layer_output_num=10;%�����
n_num=20;
%Ȩֵ��������
yita=0.01;
%bias��ʼ����ƫ��ֵ
bias_c1=(2*rand(1,20)-ones(1,20))/sqrt(20);
bias_f1=(2*rand(1,100)-ones(1,100))/sqrt(20);
%����˳�ʼ��
[kernel_c1,kernel_f1]=init_kernel(layer_c1_num,layer_f1_num);
%pooling�˳�ʼ��
pooling_a=ones(2,2)/4;
%ȫ���Ӳ��Ȩֵ
weight_f1=(2*rand(20,100)-ones(20,100))/sqrt(20);
weight_output=(2*rand(100,10)-ones(100,10))/sqrt(100);
disp('�����ʼ�����......');
%% ��ʼ����ѵ��
disp('��ʼ����ѵ��......');
for iter=1:20%��������ѵ���������
    for n=1:n_num
        for m=0:layer_output_num-1
            %��ȡ������ͼƬ����
            train_data=imread(['images\'  num2str(m)  '_'  num2str(n)  '.bmp']);
            train_data=double(train_data);%uint8ת����
            % ȥ��ֵ
            %       train_data=wipe_off_average(train_data);
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
            %         if (Error_cost<-0.98)
            %             break;
            %         end
            %% ������������
            [kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1]=CNN_upweight(yita,Error_cost,m,train_data,...
                state_c1,state_s1,...
                state_f1,state_f1_temp,...
                output,...
                kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1);
        end
    end
end
disp('����ѵ����ɣ���ʼ����......');
count=0;
for n=1:n_num
    for m=0:layer_output_num-1
        %��ȡ����
        train_data=imread(['images\'  num2str(m)  '_'  num2str(n)  '.bmp']);
        train_data=double(train_data);
        % ȥ��ֵ
        %       train_data=wipe_off_average(train_data);
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
        [p,classify]=max(output);
        if (classify==m+1)
            count=count+1;
        end
        fprintf('��ʵ����Ϊ%d  ������Ϊ%d  ����ֵΪ%d \n',m,classify-1,p);
    end
end
cc=count/(n_num*layer_output_num);
fprintf('��ȷ��Ϊ%f',cc*100);
