function out=f_m(a)
b = 1:max(a);%д�������п��ܴ��ڵ������ļ���
c = histc(a,b);%�ó���Ԫ����A�г��ֵĴ���
[~, max_index] = max(c);%a�г��ִ�������Ԫ����b�е��±�max_index��
out = b(max_index);
end