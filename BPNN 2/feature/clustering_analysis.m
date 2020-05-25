%%  clustering analysis聚类分析
clear;
close all;
clc;
data=[];%变量初始化
%%
%a为第一列数据，b为第二列数据，c为第三列数据
m_data=feature_extraction();
%各组个数
n_class(1)=50;n_class(2)=50;n_class(3)=50;n_class(4)=50;n_class(5)=50;
m_length=length(m_data);
reall={};
m_single=1;
%%
u_eva=zeros(m_length,3);
for m_single=1:m_length
    xi=m_single/m_length;
    h = waitbar(xi);%进度条
    data=m_data{m_single};
    
    %基于分区的方法
    rec1=kmeans(data,5);  %k-means聚类，选取均值，默认已经使用k-means++
    rec2= kmedoids(data,5,'Distance','mahalanobis');%k-medoids聚类，选取中心点，马氏距离
    rec3=kmeans(data,5,'Distance','cityblock');%k-medians聚类，选取中值，通过“kmeans”中设置“Distance”为“cityblock”实现
    %intelligent k-means%genetic k-means%k-modes%kernel k-means
    
    %基于密度的方法
    %k近领域%DBSCAN
    
    %基于网格的方法
    %STING%CLIQUE
    
    %基于模型的方法
    obj = gmdistribution.fit(data,5,'Regularize', 1e-5);rec4 = cluster(obj,data);%高斯混合模型的聚类 GMM
    %基于神经网络模型的方法 SOM
    
    %评价函数,u_eva为分析最终结果
    u_eva(m_single,1)=evaluate1(rec1,n_class);
    u_eva(m_single,2)=evaluate1(rec2,n_class);
    u_eva(m_single,3)=evaluate1(rec3,n_class);
    u_eva(m_single,4)=evaluate1(rec4,n_class);
    %分类数据集
    reall{m_single,1}=rec1;
    reall{m_single,2}=rec2;
    reall{m_single,3}=rec3;
    reall{m_single,4}=rec4;
    
    close(h);
    data=[];
end
%% 统计较为合适的特征值
clear data_rank
kd=1;%kd为输出的最终特征量，其值为对应特征的序号
for i=1:size(u_eva,1)
    ku=0;
    for j=1:size(u_eva,2)
        if u_eva(i,j)>0.65
            ku=ku+1;
        end
    end
    if ku>1;
        data_rank(kd)=i;
        kd=kd+1;
    end
end
