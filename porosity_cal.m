% 计算图片中孔隙率，多组比较
clear,close all,clc;
% ---主要功能---
% --读取图像
% --选择截取部分
% --计算孔隙率
% --显示图像
%% 变量解释&常量定义
% image_rgb{n}-----读取的原图
% image_gray{n}----灰度图
% image_target{n}--截取部分
n = 4;       % n---图像数量
% [x,y]手动选择的截取点坐标
time = datestr(now,30);   %输出格式为‘20000301T154517’的当前时间，2000-03-01 15:45:17
% BW{i}------------目标二值化图像
% T{i}-------------大津法阈值
%% 读取图像
image_rgb{1} = imread('E:\00_公益项目\01_实验照片\2018.01-03_压缩实验\IMG_1301.JPG');
image_rgb{2} = imread('E:\00_公益项目\01_实验照片\2018.01-03_压缩实验\IMG_1311.JPG');
image_rgb{3} = imread('E:\00_公益项目\01_实验照片\2018.01-03_压缩实验\IMG_1321.JPG');
image_rgb{4} = imread('E:\00_公益项目\01_实验照片\2018.01-03_压缩实验\IMG_1337.JPG');
for i = 1:n
    image_gray{i} = rgb2gray(image_rgb{i});                                %转灰度
end
clear image_rgb;                                                           %释放原图变量
%% 选择截取部分
% 下面获取截取部分对角点坐标
imshow(image_gray{1});
[x,y] = ginput(2)                                                          %鼠标选取图像坐标；（2）代表选两个点；选择的坐标非整数需要进行取整运算
x(:) = round(x(:));                                                        %坐标取整数，四舍五入到最近整数
y(:) = round(y(:));                                                        %坐标取整数
% 下面截取图像&存储图像
for i = 1:n
    image_target{i} = image_gray{i}(y(1):y(2),x(1):x(2));                  %截取原图中选取两点所包围的矩形部分
    image_compare{i} = image_gray{i};
    image_compare{i}(y(1):y(2),x(1):x(2)) = 0;                             %将截取部分涂黑
    T(i) = graythresh(image_target{i});                                    %计算大津法阈值
    BW{i} = im2bw(image_target{i},T(i));                                   %二值化图像
    %存储
    filename1 = [time,'target',num2str(i),'.png'];                         %target文件名
    %filename2 = [time,'compare',num2str(i),'.png'];                       %compare文件名
    imwrite(image_target{i},filename1);                                    %存储截取图像
    %imwrite(image_compare{i},filename2);                                  %存储比较图像
end
%% 计算孔隙率
[r,c] = size(BW{1});                                                       %提取BW矩阵大小信息
targetsize = r * c;                                                         %计算总像素数量
for i = 1:n
    cereals(i) = length(find(BW{i}==1));                                   %图像中谷物像素数
    porosity(i) = 1-(cereals(i)/targetsize)                                 %计算孔隙率
end
%% 显示图像
figure(1);                                                                 %截取部分位置图
for i = 1:n
    subplot(2,2,i);imshow(image_compare{i});
    title(num2str(i));
    hold on;
end
figure(2);                                                                 %截取部分灰度图
for i = 1:n
    subplot(2,2,i);imshow(image_target{i});
    title(num2str(i));
    hold on;
end
figure(3);                                                                 %截取部分二值图
for i = 1:n
    subplot(2,2,i);imshow(BW{i});
    title(['压力',num2str(i),'   ','孔隙率',num2str(porosity(i))]);
    hold on;
end