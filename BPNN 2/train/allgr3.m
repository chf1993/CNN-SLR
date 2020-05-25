function [out_x,out_y,out_z]=allgr3(x,y,z)%最大偏移量变化量判断
start_value=0.05;%开始阈值
start_interval=15;%开始判断间隔
end_value=0.12;%结束阈值
end_interval=15;%结束判断间隔
end_time=80;%结束持续时间
m=length(x);
x(isnan(x))=[];y(isnan(y))=[];z(isnan(z))=[];%去除NaN
data_in_full(:,1)=x;data_in_full(:,2)=y;data_in_full(:,3)=z;
%n{1,3}=1:3;%预分配内存
for i=start_interval+1:m-start_interval-1
    if abs(data_in_full(i,1)-data_in_full(i-start_interval,1))>start_value||abs(data_in_full(i,2)-data_in_full(i-start_interval,2))>start_value||abs(data_in_full(i,3)-data_in_full(i-start_interval,3))>start_value%开始
        break
    end
end
k=0;
for j=i:m-end_interval-1
    if abs(data_in_full(j,1)-data_in_full(j+end_interval,1))<end_value&&abs(data_in_full(j,2)-data_in_full(j+end_interval,2))<end_value&&abs(data_in_full(j,3)-data_in_full(j+end_interval,3))<end_value
        k=k+1;
        if k>end_time
            break
        end
    end
end
out_x=data_in_full(i:j,1);out_y=data_in_full(i:j,2);out_z=data_in_full(i:j,3);
end
