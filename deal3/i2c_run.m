%% I2C����
clc;clear;close all;

i2cobj = i2c('Aardvark',0,'32h');
%%
mypi = raspi;%����һ�����ӡ�ʹ�ô��﷨���ӻ��������ӵ�ͬһ��塣����������һ������
[i2cAddresses] = scanI2CBus(mypi,bus);
%%
a = arduino('COM15','Due','Libraries','I2C');
scanI2CBus(a,1)
%%
instrhwinfo('i2c','Aardvark')
instrhwinfo('i2c')
%%
fopen(i2cobj);
cc=fread(i2cobj,12);
fclose(i2cobj);