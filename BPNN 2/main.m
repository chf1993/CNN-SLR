%% �������ó��򣬵��μ��ʹ��
clc;clear;close all;
%tez
load('net_a')
%% ��ȡ��������
file_in='E:\�о���\ä������ʶ��\���ݲɼ�\20180111\0 (10).txt';
data_in=importdata(file_in);
data_x=data_in(:,1);data_y=data_in(:,2);data_z=data_in(:,3);
data_x=time1(data_x,500);data_y=time1(data_y,500);data_z=time1(data_z,500);%�������ݳ���
n=[data_x;data_y;data_z]';
data_test=[n(:,1) ;n(:,2) ;n(:,3)];
%% �������ݹ�һ��
minI=PS.xmin;maxI=PS.xmax;%�����һ��ָ��
minI(length(minI))=[];maxI(length(maxI))=[];
testInput =  mapminmax ( data_test, minI, maxI );
%% ����
Y = sim( net , testInput);
s2= size( Y,2 ) ;
[~ , Index] = max(Y) ;
if Index==10
    Index=0;
end
Index=num2str(Index); 
reminder_out=questdlg(['����Ϊ',Index],'��ʾ','Yes','No','Yes');
