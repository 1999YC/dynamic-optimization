%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% �������ͨ�����󣬽�������ļ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lx=length(x0);
sb=[];
m=NO;
h=Nh;
tf=n*h;%ĩ��ʱ��
[Lt,La1,La,T]=OCFElagrange(linspace(0,h,m+2));%�������ʱ��Ҫ���������ղ�ֵ����,La1Ϊt=1ʱ
pro=@(u)reshape(u,lu,length(u)/lu)';
ipro=@(u)reshape(u',numel(u),1);
U=ipro(U);Ul=ipro(Ul);UM=ipro(UM);
fun=@(U)funocfe(U,x0);[J,dJu,XX,XU]=fun(U); 
L(x0,U(:,1));
try cL(x0,U(:,1));%������������״̬����ʽԼ��
    cfun=@(U)cfunocfe(U,x0);[ck,sssss,dck,ssss]=cfun(U);%�ݶȾ����ʽ dck(i,j)=cj/ui
catch cfun=[];%���û�ж������״̬����ʽԼ��
end;

%������ã���ѡ���㷨���ڵ㷨'interior-point','sqp','trust-region-reflective' (current default),
%'active-set''interior-point' (will become default in a future release),'sqp'
%�Ż�������ʾ
% @optimplotx plots the current point
% @optimplotfunccount plots the function count
% @optimplotfval plots the function value
% @optimplotconstrviolation plots the maximum constraint violation
% @optimplotstepsize plots the step size
% @optimplotfirstorderopt plots the first-order optimality measure
options=optimset('display','iter','MaxFunEvals',maxfunevals,'GradConstr','on','GradObj','on',...
    'Algorithm',algorithm,'PlotFcns',plotfcns);
[Uopt,fval,exitflag,output,lambda]= fmincon(fun,U,[],[],[],[],Ul,UM,cfun,options);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[J,dJu,X1,XU]=fun(Uopt);
Xopt=[x0;X1];ttx=0:h/(m+1):tf;
Uopt=pro(Uopt);ttu=0:h:tf-h;
figure(2);plot(ttu,Uopt);title('���ƹ켣');xlabel('ʱ��');
figure(3);plot(ttx,Xopt);title('״̬�켣');xlabel('ʱ��');
