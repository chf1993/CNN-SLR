%% Lpms Data recording demo���βɼ�
% Summary: 
% This example demonstrate how to obtain and plot real time data from LpmsSensor
%���������ʾ����δ�LpmsSensor��ȡ�ͻ���ʵʱ����
%
% Author: H.E.Yap
% Date: 2016/07/19    
% Revision: 0.1 
% Copyright: LP-Research Inc. 2016

close
clear
clc

%% Parameters ����
nData = 1000;   % number of data to record
nCount = 1;
COMPort = 'COM15';
baudrate = 115200;%������
lpSensor = lpms();%��������ʼ��
ts = zeros(nData,1);
accData = zeros(nData,3);%���ٶ�����
gyrData= zeros(nData,3);%����������
magData= zeros(nData,3);%�ų�����

%% Connect to sensor
if ( ~lpSensor.connect(COMPort, baudrate) )
    return 
end
disp('sensor connected')

%% Set streaming mode
lpSensor.setStreamingMode();

disp('Accumulating sensor data')
while nCount <= nData
    d = lpSensor.getQueueSensorData();%queue����
    if (~isempty(d))
        ts(nCount) = d.timestamp;
        accData(nCount,:) = d.acc;%���ٶ�����
        gyrData(nCount,:) = d.gyr;%����������
        magData(nCount,:) = d.mag;%�ų�����
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
ylabel('���ٶ�  Acc(g)');
grid on

figure(2)
plot(ts-ts(1), gyrData);
xlabel('timestamp(s)');
ylabel('����  Gyr(deg/s)');
grid on

figure(3)
plot(ts-ts(1), magData);
xlabel('timestamp(s)');
ylabel('�ų�  Mag(uT)');
grid on
