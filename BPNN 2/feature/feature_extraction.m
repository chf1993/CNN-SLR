%% 相对于Untitled_tezheng，使用循环提取计算
%feature extraction特征提取
function m=feature_extraction()
xc='E:\研究生\盲人手势识别\数据采集\20180111\';
A=dir(fullfile(xc,'*.txt'));
a_long=length(A);
m={};f={};c={};az={};%cell数组初始化，必须存在，否则可能报错
for t=1:a_long
    %数据载入
    xe=A(t).name;
    ax=importdata([xc,xe]);
    a1=ax(:,1);a2=ax(:,2);a3=ax(:,3);
    %预处理
    a1=smooth(a1);a2=smooth(a2);a3=smooth(a3);%滤波
    a1=(a1-min(a1))/(max(a1)-min(a1));a2=(a2-min(a2))/(max(a2)-min(a2));a3=(a3-min(a3))/(max(a3)-min(a3));%归一化
    a1=time1(a1,500);a2=time1(a2,500);a3=time1(a3,500);
    [a1,a2,a3]=allgr3(a1,a2,a3);%起止点截取
    a1=time1(a1,300);a2=time1(a2,300);a3=time1(a3,300);
    ain(:,1)=a1;ain(:,2)=a2;ain(:,3)=a3;
    [f{1},~] = ksdensity(a1);[f{2},~] = ksdensity(a2);[f{3},~] = ksdensity(a3);%概率密度函数
    c{1}(t,:)=aryule(a1,6);c{2}(t,:)=aryule(a2,6);c{3}(t,:)=aryule(a3,6);%自回归(谱)
    az{1}=autocorr(a1,a_long-1);az{2}=autocorr(a2,a_long-1);az{3}=autocorr(a3,a_long-1);%自相关
    %具体特征
    for i=1:3
        a1=ain(:,i);
        fii=f{i};%导入概率密度函数
        ci=c{i};%导入自回归
        azi=az{i};%导入自相关
        %具体计算
        m{1}(t,i)=mean(a1);%1均值
        m{2}(t,i)=max(diff(a1));%2最大导数
        m{3}(t,i)=mean(fii);%3平均概率密度f
        m{4}(t,i)=median(a1);%4中值
        m{5}(t,i)=ci(t,7);%5 自回归系数7
        m{6}(t,i)=find(a1==max(a1),1);%6最大值所在位置
        m{7}(t,i)=find(a1==min(a1),1);%7最小值所在位置
        m{8}(t,i)=std(fii);%8方差概率密度f
        m{9}(t,i)=ci(t,2);%9 自回归系数2
        m{10}(t,i)=std(a1);%10方差
        m{11}(t,i)=ci(t,3);%11 自回归系数3
        m{12}(t,i)=ci(t,4);%12 自回归系数4
        m{13}(t,i)=max(fii);%13最大概率密度f
        m{14}(t,i)=ci(t,5);%14 自回归系数5
        m{15}(t,i)=ci(t,6);%15 自回归系数6
        m{16}(t,i)=mean(azi);%16自相关平均值
        m{17}(t,i)=min(azi);%17自相关最小值
        m{18}(t,i)=max(diff(azi)); %18自相关最大导
        m{19}(t,i)=std(azi);%19自相关方差
        m{20}(t,i)=max(diff(a1));%20最大导数(近似)
        m{21}(t,i)=min(diff(a1));%21最小导数(近似)
        clear fi ci a1
    end
    clear xe ax
end
clear t A matches
