%% �Ľ������ۺ�����������Ӧ��������
function k=evaluate1(data,n)
l_in=length(n);
out=zeros(l_in,1);ratio_occ=zeros(l_in,1);

compare=data(1:n(1));%�����Ƚ�������ȡ����
out(1)=f_m(compare);%Ѱ��������������
ratio_occ(1)=length(find(compare==out(1)))/n(1);%����������������ĸ�����ռ����

cc=n(1);
for i=2:l_in
    compare=data(cc+1:cc+n(i));
    cc=cc+n(i);
    for j=1:i-1
        ot=out(j);
        compare(compare==ot)=[];%ȥ����һ�����Ѿ����������
    end
    ot=f_m(compare);
    if isempty(ot)
        ot=0;%���Ϊ�ո���
    end
    out(i)=ot;
    if isempty(compare)==0
        ratio_occ(i)=length(find(compare==ot))/n(i);
    else
        ratio_occ(i)=0;
    end
end

if size(n,1)==1
    n=n';
end
k=(sum(ratio_occ.*n))/(sum(n));

end