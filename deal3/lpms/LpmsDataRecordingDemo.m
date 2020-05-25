%% Lpms Data recording demo单次采集
% Summary: 
% This example demonstrate how to obtain and plot real time data from LpmsSensor
%这个例子演示了如何从LpmsSensor获取和绘制实时数据
%
% Author: H.E.Yap
% Date: 2016/07/19    
% Revision: 0.1 
% Copyright: LP-Research Inc. 2016

close
clear
clc

%% Parameters 参数
nData = 1000;   % number of data to record
nCount = 1;
COMPort = 'COM15';
baudrate = 115200;%波特率
lpSensor = lpms();%传感器初始化
ts = zeros(nData,1);
accData = zeros(nData,3);%加速度数据
gyrData= zeros(nData,3);%陀螺仪数据
magData= zeros(nData,3);%磁场数据

%% Connect to sensor
if ( ~lpSensor.connect(COMPort, baudrate) )
    return 
end
disp('sensor connected')

%% Set streaming mode
lpSensor.setStreamingMode();

disp('Accumulating sensor data')
while nCount <= nData
    d = lpSensor.getQueueSensorData();%queue队列
    if (~isempty(d))
        ts(nCount) = d.timestamp;
        accData(nCount,:) = d.acc;%加速度数据
        gyrData(nCount,:) = d.gyr;%陀螺仪数据
        magData(nCount,:) = d.mag;%磁场数据
        nCount=nCount + 1;
    end
end
disp('Done')
if (lpSensor.disconnect())
    disp('sensor disconnected')
end

figure(1)
plot(ts-ts(1), accData);
xlabel('timestamp(s)');
ylabel('加速度  Acc(g)');
grid on

figure(2)
plot(ts-ts(1), gyrData);
xlabel('timestamp(s)');
ylabel('陀螺  Gyr(deg/s)');
grid on

figure(3)
plot(ts-ts(1), magData);
xlabel('timestamp(s)');
ylabel('磁场  Mag(uT)');
grid on
