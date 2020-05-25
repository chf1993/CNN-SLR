function out=f_m(a)
b = 1:max(a);%写出数组中可能存在的整数的集合
c = histc(a,b);%得出各元素在A中出现的次数
[~, max_index] = max(c);%a中出现次数最多的元素在b中的下标max_index。
out = b(max_index);
end