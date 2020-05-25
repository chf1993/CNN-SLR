%% Lpms Realtime Plot demo连续采集
% Summary:
% This example demonstrate how to obtain
% and plot real time data from LpmsSensor
%
% Author: H.E.Yap
% Date: 2016/07/19
% Revision: 0.1
% Copyright: LP-Research Inc. 2016
close
clear
clc
%% Parameters参数
T = 400;
nCount = 1;
COMPort = 'COM15';
baudrate = 115200;
lpSensor = lpms();
accData = zeros(T,3);
gyrData=zeros(T,3);
magData=zeros(T,3);

%% Connect to sensor
if ( ~lpSensor.connect(COMPort, baudrate) )
    return
end
disp('sensor connected')

%% Set streaming mode
lpSensor.setStreamingMode();

%% Loop Plot
figure('doublebuffer','on', ...
    'CurrentCharacter','a', ...
    'WindowStyle','modal')

while double(get(gcf,'CurrentCharacter'))~=27
    nData = lpSensor.hasSensorData();
    for i=1:nData
        d = lpSensor.getQueueSensorData();
        if nCount == T
            accData=accData(2:end, :);
            gyrData=gyrData(2:end, :);
            magData=magData(2:end, :);
        else
            nCount = nCount + 1;
        end
        accData(nCount,:) = d.acc;
        gyrData(nCount,:) = d.gyr;
        magData(nCount,:) = d.mag;
    end
    
    subplot(3,1,1)
    plot(1:T,accData)
    ylabel('加速度  Acc(g)');
    grid on;
    
    subplot(3,1,2)
    plot(1:T,gyrData)
    ylabel('陀螺  Gyr(deg/s)');
    grid on;
    
    subplot(3,1,3)
    plot(1:T,magData)
    ylabel('磁场  Mag(uT)');
    grid on;
    
    drawnow
end

set(gcf,'WindowStyle','normal');
if (lpSensor.disconnect())
    disp('sensor disconnected')
end