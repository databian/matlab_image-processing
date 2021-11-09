% 计算一组不同压力下粮堆孔隙率，绘制压力孔隙率曲线
clear,close all,clc;
% ---主要功能---
% --读取图像
% --选择截取部分
% --计算孔隙率
% --显示图像
% --绘制拟合曲线
%% 变量解释&常量定义
% image_rgb{n}-----读取的原图
% image_gray{n}----灰度图
% image_target{n}--截取部分
n = 13;       % n---图像数量
% [x,y]手动选择的截取点坐标
time = datestr(now,30);   %输出格式为‘20000301T154517’的当前时间，2000-03-01 15:45:17
% BW{i}------------目标二值化图像
% T{i}-------------大津法阈值
%% 自然堆积读取
image_rgb{1} = imread('E:\00_公益项目\01_实验照片\20200113自然堆积\3cm.JPG');
image_rgb{2} = imread('E:\00_公益项目\01_实验照片\20200113自然堆积\6cm.JPG');
image_rgb{3} = imread('E:\00_公益项目\01_实验照片\20200113自然堆积\9cm.JPG');
image_rgb{4} = imread('E:\00_公益项目\01_实验照片\20200113自然堆积\12cm.JPG');
image_rgb{5} = imread('E:\00_公益项目\01_实验照片\20200113自然堆积\15cm.JPG');
%% 读取图像
image_rgb{1} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\0.JPG');
image_rgb{2} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\1.JPG');
image_rgb{3} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\2.JPG');
image_rgb{4} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\3.JPG');
image_rgb{5} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\4.JPG');
image_rgb{6} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\5.JPG');
image_rgb{7} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\6.JPG');
image_rgb{8} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\7.JPG');
image_rgb{9} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\8.JPG');
image_rgb{10} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\9.JPG');
image_rgb{11} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\10.JPG');
image_rgb{12} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\11.JPG');
image_rgb{13} = imread('E:\00_公益项目\01_实验照片\数据筛选\34.01\12.JPG');
for i = 1:n
    image_gray{i} = rgb2gray(image_rgb{i});                                %转灰度
end
clear image_rgb;                                                           %释放原图变量
%% 选择截取部分
% 下面获取截取部分对角点坐标
imshow(image_gray{5});
[x,y] = ginput(2)                                                          %鼠标选取图像坐标；（2）代表选两个点；选择的坐标非整数需要进行取整运算
x(:) = round(x(:));                                                        %坐标取整数，四舍五入到最近整数
y(:) = round(y(:));                                                        %坐标取整数

% filename0 = ['rgb',num2str(i),time,'.png'];                         %target文件名
% imwrite(image_rgb{1}(y(1):y(2),x(1):x(2)),filename0);                                    %存储截取图像

% 下面截取图像&存储图像
for i = 1:n
    image_target{i} = image_gray{i}(y(1):y(2),x(1):x(2));                  %截取原图中选取两点所包围的矩形部分
    image_compare{i} = image_gray{i};
    image_compare{i}(y(1):y(2),x(1):x(2)) = 0;                             %将截取部分涂黑
    T(i) = graythresh(image_target{i});                                    %计算大津法阈值
    BW{i} = im2bw(image_target{i},T(i));                                   %二值化图像
    %存储
    filename1 = ['target',num2str(i),time,'.png'];                         %target文件名
    %filename2 = ['compare',num2str(i),time,'.png'];                       %compare文件名
    %imwrite(image_target{i},filename1);                                    %存储截取图像，使用时去掉注释符号即可
    %imwrite(image_compare{i},filename2);                                  %存储比较图像，使用时去掉注释符号即可
end
%% 计算孔隙率
[r,c] = size(BW{1});                                                       %提取BW矩阵大小信息
targetsize = r * c;                                                         %计算总像素数量
for i = 1:n
    cereals(i) = length(find(BW{i}==1));                                   %图像中谷物像素数
    porosity(i) = 1-(cereals(i)/targetsize);                                 %计算孔隙率
end
%% 显示图像
figure(1);                                                                 %截取部分位置图
for i = 1:n
    subplot(4,4,i);imshow(image_compare{i});
    title(num2str(i-1));
    hold on;
end
figure(2);                                                                 %截取部分灰度图
for i = 1:n
    subplot(4,4,i);imshow(image_target{i});
    title(num2str(i-1));
    hold on;
end
figure(3);                                                                 %截取部分二值图
for i = 1:n
    subplot(4,4,i);imshow(BW{i});
    title(['压力',num2str(i-1),'   ','孔隙率',num2str(porosity(i))]);
    filename3 = ['BW',num2str(i),time,'.png'];                         %target文件名
    imwrite(BW{i},filename3);                                    %存储截取图像
    hold on;
end
figure(4);
A(:,1) = [0,2.6,5.2,10.39,20.79,41.57,83.15,124.72,166.3,207.87,249.45,291.02,332.6];   %压力
A(:,2) = [0,71.1,103.5,144.8,186.12,235,292.9,327.8,356.9,380.2,400.7,417.9,443];
%A(:,1) = [0.53,10.92,42.10,291.55];                       %压力
% A(:,2) = [0,144.8,235,417.9];                                 %位移
A(:,3) = porosity(:);                                        %孔隙
plot(A(:,2),A(:,3));
xlabel('位移');
ylabel('孔隙度');

%% 绘制拟合曲线
figure(5)
% scatter(A(:,1),A(:,3));
% hold on
plot(A(:,1),A(:,3),'ro');                                                  %根据数列绘制散点图
hold on
P = polyfit(A(:,1),A(:,3),2);                                              %拟合曲线，最后一位数字为拟合阶数，拟合后函数为P(1)x^2+P(2)x+P(3)
xi =  0:20:360;
yi = polyval(P,xi);
plot(xi,yi,'k');
hold on
title('压力孔隙度曲线');
xlabel('压力');
ylabel('孔隙度');
