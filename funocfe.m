function [J,dJu,XX,XU]=funocfe(U,x0);
global Lt La1 La T;
global f fx fu L Lx Lu cL cLx cLu n lx lu Nh NO
U=reshape(U,lu,n)';
m=NO;h=Nh;%hΪ��Ԫ���ȣ�m+1Ϊ���޵�Ԫ�ϵ����õ���Ŀ,�ܳ�tf=h*n.
%�������н��о��Ȳ�ֵ����T=h:h/(m+1):h;
%[Lt,La1,La,T]=OCFElagrange(linspace(0,h,m+2));%�������ʱ��Ҫ���������ղ�ֵ����,La1Ϊt=1ʱ
lis=Lt;lis(:,1)=[];lis(1,:)=[];lis1=inv(lis');bt=lis1(end,:);

%x0=[1000,1,1];
lx=length(x0);%����״̬��ֵ
sizeX1=m+1;%����optfunʱҪ�õ��ĺ���

XX=[];
Flag=[];ode=[];II=[];%����ֵ�洢
li=(m+1)*lx*n;
ODEX=sparse(li,li);ODEU=sparse(li,n*lu);
J=0;Jx=sparse(1,li);Ju=sparse(1,n*lu);
dJu=sparse(1,n*lu);

for k=1:n;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    u=U(k,:);fi=@(x)f(x,u);fix=@(x)fx(x,u);fiu=@(x)fu(x,u);
optfun=@(X)OCFEode4(X,x0,2,sizeX1,fi,fix,fiu,lu);%ÿһ��Ԫ�ϵ�΢��Լ�������ſ˱Ⱦ���,����Lt�Ѿ��淶�����˴�ȡh=2
li=4*m+4;dh=h/li;X=x0;lix=x0;
for i=1:li;lix=lix+dh*f(lix,u);X=[X;lix];end;X=interp1(0:dh:h,X,T);%�²�һ����ʼֵ������ţ�ٵ��������
%��һ����ŷ����������ϲ�ֵ������Ԫ�ϲ�ֵ��״̬��������Ԥ�⣬���һ�����ʵĵ�����ʼ��
%��һ����ʮ�ֱ�Ҫ�ģ����򣬲������ʱ�佫���ӵ�ԭ��������������Ҫ���ǽ��Ǵ���ģ���������
X=reshape(X',numel(X),1);%��ԭ���ģ�m+1)*lx����ת��Ϊ��������ʽ���Է���@optfun����������淶
flag=0;
for i=1:20;%ţ�ٵ������������Ԫ�ϵ�΢��Լ�����̣��õ�m+1����ֵ��
 %[li,A]=optfun(X);
if i==1;[li,A]=optfun(X);else li=optfun(X);end;%ʹ�ö���ţ�ٵ����������ټ����ſ˱Ⱦ����ʱ��
if norm(li)<=1e-6;flag=1;break;end;
dX=-A\li;X=X+dX;
end;
Flag=[Flag,flag];ode=[ode,norm(li)];II=[II,i];
Xr=reshape(X,lx,sizeX1);Xr=Xr';%��������X��ԭΪ��m+1)*lx������ʽXr
XX=[XX;Xr];%����״̬����
x0=Xr(end,:);

%����ODEX��ODEU
if nargout>1;
[li,odex,odex0,odeu]=optfun(X);
li0=(m+1)*(k-1)*lx;li1=li0+1:li0+(m+1)*lx;li2=li0+1:li0+(m+1)*lx;
li3=li0-lx+1:li0;li4=(k-1)*lu+1:(k-1)*lu+lu;
ODEX(li1,li2)=odex;
if k>1;ODEX(li1,li3)=odex0;end;
ODEU(li1,li4)=odeu;
end;
%����Ŀ�꺯��
li0=(m+1)*(k-1)*lx;
Ji=0;liju=sparse(1,lu);
for i=1:m+1;
    xi=Xr(i,:);%Xr, m*lx
    bi=bt(i);
    Ji=Ji+bi*L(xi,u);
    if nargout>1;Jx(li0+(i-1)*lx+1:li0+i*lx)=bi*Lx(xi,u);
    liju=liju+bi*Lu(xi,u);end;
end;
if nargout>1;Ju((k-1)*lu+1:k*lu)=liju;end;
J=J+Ji;

end;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout>1;
XU=-ODEX\ODEU;
dJu=Jx*XU+Ju;
dJu=dJu';%���������
dJu=full(dJu);
end;

%Uli=U;li=20;ep=1e-5;Uli(li)=U(li)+ep;[li0,sb]=funOCFE(U);li1=funOCFE(Uli);
%[sb(li),(li1-li0)/ep]
