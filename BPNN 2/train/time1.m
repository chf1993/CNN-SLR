function k=time1(n,p)         
n(isnan(n))=[];%ȥ��NaN        
 s=length(n);  
 x=1:s;
x2=linspace(1,s,p);
k=interp1(x,n,x2);
