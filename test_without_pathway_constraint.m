%��״̬Լ���Ż��������
warning off
clear 
clc
global Lt La1 La T;
global f fx fu L Lx Lu cL cLx cLu n lx lu Nh NO;  

NO=3;%NO+1Ϊ���޵�Ԫ��ȡ�����õ���,���õ��ʵ����ӣ������Խ��ȷ���������ʱ��Խ��
Nh=0.1;%����Ԫ���ȣ����޵�Ԫ������ᵼ��΢�ַ���ģ��ʧ��
clc
belta=0.33;gama=0.18;k=0.19;
 f=@(x,u)[-(1-u(1))*belta*x(1)*x(3),...
         (1-u(1))*belta*x(1)*x(3)-k*x(2),...
          k*x(2)-gama*x(3)];
 fx=@(x,u)[-(1-u(1))*belta*x(3),0,-(1-u(1))*belta*x(1);...
           (1-u(1))*belta*x(3),-k,(1-u(1))*belta*x(1);...
           0,k,-gama];
 fu=@(x,u)[belta*x(1)*x(3);-belta*x(1)*x(3);0];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 L=@(x,u)(1-u(1))*belta*x(1)*x(3);
 Lx=@(x,u)[(1-u(1))*belta*x(3),0,(1-u(1))*belta*x(1)];
 Lu=@(x,u)-belta*x(1)*x(3);
%%%%%%%%%%%%%%%%%
x0=[1000,100,10];%���ʵ�ȡֵ
x0=10*x0/sum(x0);
n=10;
lu=1;
%%%%%%%%%%%%%%%%%%%%%�Կ��Ƶ�����
Ul=zeros(n,lu);
UM=0.33*ones(n,lu);
U=UM/2+Ul/2;
% U=UM;


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
