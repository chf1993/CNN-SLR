function kk=ttain(te_lv)
%���溯��
floder_tain='taindata\tain1.txt';%ѵ���ļ�
floder_test='taindata\t1.txt';%�����ļ�
floder_out='taindata\';
prefix='a';
siffix='.txt';
classes_full=['0' ;'1'; '2' ;'6'; '7'];
kk=length(classes_full);
for i=1:kk
    classes=classes_full(i);
    title_full=[floder_out,prefix,classes,siffix];
    data_tain=importdata(title_full);%������Ҫ���������
    [row_data_tain,rank_data_tain]=size(data_tain);
    for t=1:floor(row_data_tain*te_lv)%����ѵ������
        fid=fopen(floder_tain,'at');
        for i1=1:rank_data_tain
            if i1~=rank_data_tain
                fprintf(fid,'%g\t',data_tain(t,i1));
            else
                fprintf(fid,'%g\n',data_tain(t,i1));
            end
        end
        fclose(fid);
    end
    for t=floor(row_data_tain*te_lv)+1:row_data_tain%���ò�������
        fid=fopen(floder_test,'at');
        for i2=1:rank_data_tain
            if i2~=rank_data_tain
                fprintf(fid,'%g\t',data_tain(t,i2));
            else
                fprintf(fid,'%g\n',data_tain(t,i2));
            end
        end
        fclose(fid);
    end
end
fclose('all');