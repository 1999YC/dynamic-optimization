%����Ʊ����Ż��������
%%%%%%%%%%%%%%%%��������
%min J=int_0^T((1-u(1))*beta*S*I)dt
%dS/dt=-(1-u(1))*beta*S*I-u(2)*S,
%dE/dt=(1-u(1))*beta*S*I-muE*E,
%dI/dt=muE*E-muI*I-u(3)*I
warning off
clear 
clc
global Lt La1 La T;
global f fx fu L Lx Lu cL cLx cLu n lx lu Nh NO;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NO=1;%NO+1Ϊ���޵�Ԫ��ȡ�����õ���,���õ��ʵ����ӣ������Խ��ȷ���������ʱ��Խ��
Nh=1;%����Ԫ���ȣ����޵�Ԫ������ᵼ��΢�ַ���ģ��ʧ�ܣ�Ӧ��ѡ<20Ϊ��
clc

%%%%%%%%%%%%%%��������
beta=0.33;muE=0.19;muI=0.18;
f=@(x,u)[-(1-u(1))*beta*x(1)*x(3)-u(2)*x(1),...
         (1-u(1))*beta*x(1)*x(3)-muE*x(2),...
        muE*x(2)-muI*x(3)-u(3)*x(3)
        ];
fx=@(x,u)[-(1-u(1))*beta*x(3)-u(2),0,-(1-u(1))*beta*x(1);
          (1-u(1))*beta*x(3),-muE,(1-u(1))*beta*x(1);
          0,muE,-muI-u(3)
        ];
fu=@(x,u)[beta*x(1)*x(3),-x(1),0;-beta*x(1)*x(3),0,0;0,0,-x(3)];
%%%%%%%%%%%%%%%%%%%%%%%Ŀ�꺯��L(x,u)
L=@(x,u)((1-u(1))*beta*x(1)*x(3));
Lx=@(x,u)[(1-u(1))*beta*x(3),0,(1-u(1))*beta*x(1)];
Lu=@(x,u)[-beta*x(1)*x(3),0,0];
%%%%%%%%%%%%%%%%%%%%%%ģ��ʱ��ֶ���n��ʱ��γ���h.  ע���Բ�ͬ��tf���ɵ���n��ֵ�Լ��ټ���ʱ��
x0=[1 .1 .01];
n=100;%ģ�ⳤ��
lu=3;
%%%%%%%%%%%%%%%%%%%%%�Կ��Ƶ�����
Ul=zeros(n,lu);
ua=beta;ub=1;uc=1;UM=[ua*ones(n,1),ub*ones(n,1),uc*ones(n,1)];%3˫���ƣ����Ʊ����½�um���Ͻ�uM
U=UM/2+Ul/2;


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




