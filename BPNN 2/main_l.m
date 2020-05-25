%clc;clear;close all;
load('net')
%addpath(pa)
%读取测试数据
xr='E:\研究生\盲人手势识别\数据采集\20180111\2 (33).txt';
ax=importdata(xr);
a1=ax(:,1);a2=ax(:,2);a3=ax(:,3);
n=tainn_BPNN(a1,a2,a3);
nn=[n(:,1) ;n(:,2) ;n(:,3)];
%测试数据归一化
minI(length(minI))=[];maxI(length(maxI))=[];
testInput = tramnmx ( nn, minI, maxI ) ;
%仿真
Y = sim( net , testInput);
[~ , Index] = max( Y) ;
if Index==10
    Index=0;
end