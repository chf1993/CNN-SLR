function tez(xe)
%����������������������ȡ�������
%xe='E:\�о���\ä������ʶ��\����56�����\';%�ļ���·��
A = dir(fullfile(xe,'*.txt'));%ԭ�ļ������ļ���
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
    y=['taindata\a',matches{1},'.txt'];%������ļ������ļ��м�������
    fid=fopen(y,'at');
    for i=1:size(n,2)
        fprintf(fid,'%g\t',n(:,i));
    end
    fprintf(fid,'%g\n',kk);
    fclose(fid);
    
    clear k1 k2 k3 a1 a2 a3 r1 r2 r3 b1 b2 b3 bv1 bv2 bv3 n kk matches x y
end
fclose('all');
