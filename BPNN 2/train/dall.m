function dall()
%ɾ������
clc;clear;close all;
A = dir(fullfile('taindata\','*.txt'));%ԭ�ļ������ļ���
for i=1:length(A)
    delete(['taindata\',A(i).name])
end