%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�����ṩ������������м�飬��Ҫ�Ǽ���ݶȼ����Ƿ�׼ȷ,�Լ���������ʽ�Ƿ���ȷ%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
check=0;
ep=1e-4;
u=1/2*Ul(1,:)+1/2*UM(1,:);
lx=length(x0);lu=length(u);
if size(x0,1)~=1;x0,disp('��ʼֵ����������������ʽ����');check=1;end;
if size(f(x0,u),2)~=lx|size(f(x0,u),1)~=1;f(x0,u),disp('����f�����������(1,lx)����');check=1;end;
if size(fx(x0,u),2)~=lx|size(fx(x0,u),1)~=lx;f(x0,u),disp('����fx�����������(lx,lx)����');check=1;end;
if size(fu(x0,u),2)~=lu|size(fu(x0,u),1)~=lx;f(x0,u),disp('����fu�����������(lx,lu)����');check=1;end;
if size(Lx(x0,u),2)~=lx|size(Lx(x0,u),1)~=1;Lx(x0,u),disp('����Lx�����������(1,lx)����');check=1;end;
if size(Lu(x0,u),2)~=lu|size(Lu(x0,u),1)~=1;Lu(x0,u),disp('����Lu�����������(1,lu)����');check=1;end;

f0=f(x0,u);L0=L(x0,u);
df0=fx(x0,u);dL0=Lx(x0,u);
try c0=cL(x0,u);dc0=cLx(x0,u);dc=[];end;
dL=[];df=[];
for i=1:length(x0);
    xi=x0;xi(i)=x0(i)+ep;
    fi=f(xi,u);Li=L(xi,u);
    try ci=cL(xi,u);dc(:,i)=((ci-c0)/ep)';end;
    df(:,i)=([fi-f0]/ep)';
    dL(:,i)=([Li-L0]/ep)';
end;
if norm(df-df0)>1e-9*norm(df);'f����fx������������',check=1;end
if norm(dL-dL0)>1e-9*norm(dL);'L����Lx������������',check=2;end
try if (norm(dc-dc0))>1e-9*norm(dc);'cL����cLx������������',check=3;end;end;
    
ep=1e-4;
u=1/2*Ul(1,:)+1/2*UM(1,:);
f0=f(x0,u);L0=L(x0,u);
df0=fu(x0,u);dL0=Lu(x0,u);
try c0=cL(x0,u);dc0=cLu(x0,u);dc=[];end;
dL=[];df=[];
for i=1:length(u);
    ui=u;ui(i)=u(i)+ep;
    fi=f(x0,ui);Li=L(x0,ui);
    try ci=cL(x0,ui);dc(:,i)=((ci-c0)/ep)';end;
    df(:,i)=([fi-f0]/ep)';
    dL(:,i)=([Li-L0]/ep)';
end;
if norm(df-df0)>1e-9*norm(df);'f����fx������������',check=4;end
if norm(dL-dL0)>1e-9*norm(dL);'L����Lx������������',check=5;end
try if (norm(dc-dc0))>1e-9*norm(dc);'cL����cLx������������',check=6;end;end;
if lu~=size(U,2)|n~=size(U,1);'U����ά�����ԣ�UӦ���ǣ�n��lu��ά����',check=7;end;
if lu~=size(Ul,2)|n~=size(Ul,1);'Ul����ά�����ԣ�UlӦ���ǣ�n��lu��ά����',check=8;end;
if lu~=size(UM,2)|n~=size(UM,1);'UM����ά�����ԣ�UMӦ���ǣ�n��lu��ά����',check=9;end;
if sum(sum(Ul>=UM))>0;'�½�Ul��ĳһλ���ϵ�ֵ�����Ͻ�UM��ͬһλ���ϵ�ֵ������',check=10;end;
if check>0;'���û��ͨ�����밴����ʾ�������',error,end;