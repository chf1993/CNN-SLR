function dall()
%删除函数
clc;clear;close all;
A = dir(fullfile('taindata\','*.txt'));%原文件所在文件夹
for i=1:length(A)
    delete(['taindata\',A(i).name])
end