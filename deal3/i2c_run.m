%% I2C配置
clc;clear;close all;

i2cobj = i2c('Aardvark',0,'32h');
%%
mypi = raspi;%创建一个连接。使用此语法连接或重新连接到同一块板。不能用来第一次连接
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