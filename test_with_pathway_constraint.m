warning off
clear 
clc
global Lt La1 La T;
global f fx fu L Lx Lu cL cLx cLu n lx lu Nh NO;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NO=1;%NO+1Ϊ���޵�Ԫ��ȡ�����õ���,���õ��ʵ����ӣ������Խ��ȷ���������ʱ��Խ��
Nh=1;%����Ԫ���ȣ����޵�Ԫ������ᵼ��΢�ַ���ģ��ʧ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=0.01;beta=4e-5;rho=0.00;%��������
% f=@(x,u)[-beta*x(1)*x(2)-u*x(1),beta*x(1)*x(2)-mu*x(2),-rho*x(3)];
% fx=@(x,u)[-beta*x(2)-u,-beta*x(1),0;beta*x(2),beta*x(1)-mu,0;0,0,-rho];
% fu=@(x,u)[-x(1);0;0];
f=@(x,u)[-beta*(1-u(1))*x(1)*x(2)-u(2)*x(1),beta*(1-u(1))*x(1)*x(2)-mu*x(2),-rho*x(3)];
fx=@(x,u)[-beta*(1-u(1))*x(2)-u(2),-beta*(1-u(1))*x(1),0;beta*(1-u(1))*x(2),beta*(1-u(1))*x(1)-mu,0;0,0,-rho];
fu=@(x,u)[beta*x(1)*x(2) -x(1);-beta*x(1)*x(2) 0;0 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=1;ku=1;%����������������
%  L=@(x,u)(c*x(2)+ku*u)*x(3);Lx=@(x,u)[0,c*x(3),(c*x(2)+ku*u)];Lu=@(x,u)ku*x(3);%Ŀ���еĻ��ֺ���
 L=@(x,u)c*x(2)*x(3)+ku*u(2)*x(3);Lx=@(x,u)[0,c*x(3),(c*x(2)+ku*u(2))];Lu=@(x,u)[0,ku*x(3)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear cL cLx cLu;
cmax=10;%��������������
% cL=@(x,u)u*x(1)-cmax;cLx=@(x,u)[u,0,0];cLu=@(x,u)x(1);%���Լ�����������x,u���ݶȺ���
cL=@(x,u)u(2)*x(1)-cmax;cLx=@(x,u)[u(2),0,0];cLu=@(x,u)[0,x(1)];%���Լ�����������x,u���ݶȺ���
cL=@(x,u)[u(2)*x(1)-cmax;u(2)*x(1)-cmax];cLx=@(x,u)[u(2),0,0;u(2),0,0];cLu=@(x,u)[0,x(1);0,x(1)];%���Լ�����������x,u���ݶȺ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0=[1000,100,1];
n=10;%���޵�Ԫ������ÿһ�����޵�Ԫ��ȡ��ͬ�Ŀ��ƣ����nҲ�൱�ڿ��Ʒֶ�����
lu=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U=0.0001*rand(n,lu);%�������һ�����еĳ�ʼ���ơ�
Ul=0*ones(size(U));%�����½�
UM=0.2*ones(size(U));%�����Ͻ�Ϊ0.2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����㷨���ã�
%��ѡ�ķ�����Լ���Ż��㷨���ڵ㷨'interior-point',�����ι滮��'sqp',������'trust-region-reflective',��Ч����'active-set'
algorithm='active-set';algorithm='interior-point';
%�Ż�����������ʾ����
% @optimplotx                    plots the current point
% @optimplotfunccount            plots the function count
% @optimplotfval                 plots the function value
% @optimplotconstrviolation      plots the maximum constraint violation
% @optimplotstepsize             plots the step size
% @optimplotfirstorderopt        plots the first-order optimality measure
plotfcns={@optimplotfval,@optimplotconstrviolation,@optimplotfirstorderopt,@optimplotx};
%�����ô���
maxfunevals=3000;

disp('����������ɣ�ת��input_check.m����������')
pause(0.5)
input_check
disp('���ͨ��,ת��ultimate.m�������ſ��Ƶ����')
pause(0.5)
ultimate
    


