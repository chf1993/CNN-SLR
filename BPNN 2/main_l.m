%clc;clear;close all;
load('net')
%addpath(pa)
%��ȡ��������
xr='E:\�о���\ä������ʶ��\���ݲɼ�\20180111\2 (33).txt';
ax=importdata(xr);
a1=ax(:,1);a2=ax(:,2);a3=ax(:,3);
n=tainn_BPNN(a1,a2,a3);
nn=[n(:,1) ;n(:,2) ;n(:,3)];
%�������ݹ�һ��
minI(length(minI))=[];maxI(length(maxI))=[];
testInput = tramnmx ( nn, minI, maxI ) ;
%����
Y = sim( net , testInput);
[~ , Index] = max( Y) ;
if Index==10
    Index=0;
end