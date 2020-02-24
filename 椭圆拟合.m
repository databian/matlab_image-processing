function [A,B,C,D,E,X_center,Y_center,a,b,q ] = ellipse_fitting( x )
%UNTITLED2 椭圆拟合
%   输入一个二维数组，根据二维数组进行最小二乘法拟合椭圆，输出椭圆的全部数据。
%  p0=[1 1 1 1 1 1];
p0=[0.005 0.005 0.005 0.005 0.005 0.005];
warning off
F=@(p,x)p(1)*x(:,1).^2+p(2)*x(:,1).*x(:,2)+p(3)*x(:,2).^2+p(4)*x(:,1)+p(5)*x(:,2)+p(6);
% 拟合系数，最小二乘方法
p=nlinfit(x,zeros(size(x,1),1),F,p0);
p(1);
p(2);
p(3);
p(4);
p(5);
p(6);

A=p(1)/p(6);
B=p(2)/p(6);
C=p(3)/p(6);
D=p(4)/p(6);
E=p(5)/p(6);


%%椭圆中心
X_center = (B*E-2*C*D)/(4*A*C - B^2);
Y_center = (B*D-2*A*E)/(4*A*C - B^2);

%%长短轴
a= 2*sqrt((2*A*(X_center^2)+2*C*(Y_center^2)+2*B*X_center*Y_center-2)/(A+C+sqrt(((A-C)^2+B^2))));
b= 2*sqrt((2*A*(X_center^2)+2*C*(Y_center^2)+2*B*X_center*Y_center-2)/(A+C-sqrt(((A-C)^2+B^2))));

%%长轴倾角
q=0.5 * atan(B/(A-C));           

%%描点
plot(x(:,1),x(:,2),'ro');

hold on;
xmin=min(x(:,1));
xmax=max(x(:,1));
ymin=min(x(:,2));
ymax=max(x(:,2));
% 作图


ezplot(@(x,y)F(p,[x,y]),[xmin - 100,xmax + 100,ymin - 100,ymax + 100]);         %作图区域
title('曲线拟合');
%legend('样本点','拟合曲线')

%输出控制
%fprintf(' X_center=%g, Y_center=%g\n',X_center,Y_center);      %椭圆中心输出
%fprintf(' q=%g\n',q);    %长轴倾角输出
%fprintf(' a=%g, b=%g\n',a,b);        %长短轴输出
end
