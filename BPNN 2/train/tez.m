function tez(xe)
%数据特征处理函数，并将提取结果保存
%xe='E:\研究生\盲人手势识别\测试56处理后\';%文件夹路径
A = dir(fullfile(xe,'*.txt'));%原文件所在文件夹
a=length(A);
for t=1:a
    x=A(t).name;
    ax=importdata([xe,x]);
    a1=ax(:,1);a2=ax(:,2);a3=ax(:,3);
    a1=time1(a1,500);a2=time1(a2,500);a3=time1(a3,500);
    n=[a1;a2;a3]';
    [~, ~, ~, matches]=regexp(x,'\d+');
    kk=str2double(matches{1});
    if kk==0
        kk=10;
    end
    y=['taindata\a',matches{1},'.txt'];%处理后文件所放文件夹及重命名
    fid=fopen(y,'at');
    for i=1:size(n,2)
        fprintf(fid,'%g\t',n(:,i));
    end
    fprintf(fid,'%g\n',kk);
    fclose(fid);
    
    clear k1 k2 k3 a1 a2 a3 r1 r2 r3 b1 b2 b3 bv1 bv2 bv3 n kk matches x y
end
fclose('all');
