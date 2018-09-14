function [ I1,w,b,porosity ] = threshold_1( gray,I )
%   自动阈值分割功能函数，输入灰度图像，输出孔隙率。
%   阈值分割
%   根据设定的阈值分割图像
%   I1--二值化的图像，w--白色的粮食面积，b--黑色的孔隙面积，porosity--孔隙率
I1 = I;
[m,n] = size(I);
w=0;
b=0;
for i = 1:m
    for j = 1:n
        if I1(i,j)>=gray
            I1(i,j)=255;
            w=w+1;
        else
            I1(i,j)=0;
            b=b+1;
        end
    end
end
porosity = b/(b+w);         %孔隙率
end
