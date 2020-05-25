function srmob(nn,title)
load('net')
nn=nn';
y='E:\研究生\盲人手势识别\BPNN\taindata\tain1.txt';%训练文件
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
load 'E:\研究生\盲人手势识别\BPNN\taindata\tain1.txt'

[input,minI,maxI] = premnmx( tain1');%按照行逐行处理
%构造输出矩阵
[s,c]=size(tain1);%s为列数，c为行数
output=[];
for i = 1 : s
    output(tain1(i,c),i  ) = 1 ;
end

%创建神经网络
net = newff( minmax(input) , [20 10] , { 'logsig' 'purelin' } , 'traingdx' ) ;

%设置训练参数
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;%学习率
net.trainParam.showWindow = false;

%开始训练
net = train( net, input , output ) ;
clear nn title c fid input s output tain1
save('net')
end