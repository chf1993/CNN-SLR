%% 最终适用程序，单次检测使用
clc;clear;close all;
%tez
load('net_a')
%% 读取测试数据
file_in='E:\研究生\盲人手势识别\数据采集\20180111\0 (10).txt';
data_in=importdata(file_in);
data_x=data_in(:,1);data_y=data_in(:,2);data_z=data_in(:,3);
data_x=time1(data_x,500);data_y=time1(data_y,500);data_z=time1(data_z,500);%调整数据长度
n=[data_x;data_y;data_z]';
data_test=[n(:,1) ;n(:,2) ;n(:,3)];
%% 测试数据归一化
minI=PS.xmin;maxI=PS.xmax;%导入归一化指标
minI(length(minI))=[];maxI(length(maxI))=[];
testInput =  mapminmax ( data_test, minI, maxI );
%% 仿真
Y = sim( net , testInput);
s2= size( Y,2 ) ;
[~ , Index] = max(Y) ;
if Index==10
    Index=0;
end
Index=num2str(Index); 
reminder_out=questdlg(['手势为',Index],'提示','Yes','No','Yes');
