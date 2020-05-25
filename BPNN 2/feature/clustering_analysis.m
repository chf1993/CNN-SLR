%%  clustering analysis�������
clear;
close all;
clc;
data=[];%������ʼ��
%%
%aΪ��һ�����ݣ�bΪ�ڶ������ݣ�cΪ����������
m_data=feature_extraction();
%�������
n_class(1)=50;n_class(2)=50;n_class(3)=50;n_class(4)=50;n_class(5)=50;
m_length=length(m_data);
reall={};
m_single=1;
%%
u_eva=zeros(m_length,3);
for m_single=1:m_length
    xi=m_single/m_length;
    h = waitbar(xi);%������
    data=m_data{m_single};
    
    %���ڷ����ķ���
    rec1=kmeans(data,5);  %k-means���࣬ѡȡ��ֵ��Ĭ���Ѿ�ʹ��k-means++
    rec2= kmedoids(data,5,'Distance','mahalanobis');%k-medoids���࣬ѡȡ���ĵ㣬���Ͼ���
    rec3=kmeans(data,5,'Distance','cityblock');%k-medians���࣬ѡȡ��ֵ��ͨ����kmeans�������á�Distance��Ϊ��cityblock��ʵ��
    %intelligent k-means%genetic k-means%k-modes%kernel k-means
    
    %�����ܶȵķ���
    %k������%DBSCAN
    
    %��������ķ���
    %STING%CLIQUE
    
    %����ģ�͵ķ���
    obj = gmdistribution.fit(data,5,'Regularize', 1e-5);rec4 = cluster(obj,data);%��˹���ģ�͵ľ��� GMM
    %����������ģ�͵ķ��� SOM
    
    %���ۺ���,u_evaΪ�������ս��
    u_eva(m_single,1)=evaluate1(rec1,n_class);
    u_eva(m_single,2)=evaluate1(rec2,n_class);
    u_eva(m_single,3)=evaluate1(rec3,n_class);
    u_eva(m_single,4)=evaluate1(rec4,n_class);
    %�������ݼ�
    reall{m_single,1}=rec1;
    reall{m_single,2}=rec2;
    reall{m_single,3}=rec3;
    reall{m_single,4}=rec4;
    
    close(h);
    data=[];
end
%% ͳ�ƽ�Ϊ���ʵ�����ֵ
clear data_rank
kd=1;%kdΪ�������������������ֵΪ��Ӧ���������
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
