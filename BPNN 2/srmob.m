function srmob(nn,title)
load('net')
nn=nn';
y='E:\�о���\ä������ʶ��\BPNN\taindata\tain1.txt';%ѵ���ļ�
c=length(nn);
if title==0
    title=10;
end
fid=fopen(y,'at');
for i1=1:c
    fprintf(fid,'%g\t',nn(i1));
end
fprintf(fid,'%g\n',title);
fclose(fid);
load 'E:\�о���\ä������ʶ��\BPNN\taindata\tain1.txt'

[input,minI,maxI] = premnmx( tain1');%���������д���
%�����������
[s,c]=size(tain1);%sΪ������cΪ����
output=[];
for i = 1 : s
    output(tain1(i,c),i  ) = 1 ;
end

%����������
net = newff( minmax(input) , [20 10] , { 'logsig' 'purelin' } , 'traingdx' ) ;

%����ѵ������
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;%ѧϰ��
net.trainParam.showWindow = false;

%��ʼѵ��
net = train( net, input , output ) ;
clear nn title c fid input s output tain1
save('net')
end