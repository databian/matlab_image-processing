% ����ͼƬ�п�϶�ʣ�����Ƚ�
clear,close all,clc;
% ---��Ҫ����---
% --��ȡͼ��
% --ѡ���ȡ����
% --�����϶��
% --��ʾͼ��
%% ��������&��������
% image_rgb{n}-----��ȡ��ԭͼ
% image_gray{n}----�Ҷ�ͼ
% image_target{n}--��ȡ����
n = 4;       % n---ͼ������
% [x,y]�ֶ�ѡ��Ľ�ȡ������
time = datestr(now,30);   %�����ʽΪ��20000301T154517���ĵ�ǰʱ�䣬2000-03-01 15:45:17
% BW{i}------------Ŀ���ֵ��ͼ��
% T{i}-------------�����ֵ
%% ��ȡͼ��
image_rgb{1} = imread('E:\00_������Ŀ\01_ʵ����Ƭ\2018.01-03_ѹ��ʵ��\IMG_1301.JPG');
image_rgb{2} = imread('E:\00_������Ŀ\01_ʵ����Ƭ\2018.01-03_ѹ��ʵ��\IMG_1311.JPG');
image_rgb{3} = imread('E:\00_������Ŀ\01_ʵ����Ƭ\2018.01-03_ѹ��ʵ��\IMG_1321.JPG');
image_rgb{4} = imread('E:\00_������Ŀ\01_ʵ����Ƭ\2018.01-03_ѹ��ʵ��\IMG_1337.JPG');
for i = 1:n
    image_gray{i} = rgb2gray(image_rgb{i});                                %ת�Ҷ�
end
clear image_rgb;                                                           %�ͷ�ԭͼ����
%% ѡ���ȡ����
% �����ȡ��ȡ���ֶԽǵ�����
imshow(image_gray{1});
[x,y] = ginput(2)                                                          %���ѡȡͼ�����ꣻ��2������ѡ�����㣻ѡ��������������Ҫ����ȡ������
x(:) = round(x(:));                                                        %����ȡ�������������뵽�������
y(:) = round(y(:));                                                        %����ȡ����
% �����ȡͼ��&�洢ͼ��
for i = 1:n
    image_target{i} = image_gray{i}(y(1):y(2),x(1):x(2));                  %��ȡԭͼ��ѡȡ��������Χ�ľ��β���
    image_compare{i} = image_gray{i};
    image_compare{i}(y(1):y(2),x(1):x(2)) = 0;                             %����ȡ����Ϳ��
    T(i) = graythresh(image_target{i});                                    %��������ֵ
    BW{i} = im2bw(image_target{i},T(i));                                   %��ֵ��ͼ��
    %�洢
    filename1 = [time,'target',num2str(i),'.png'];                         %target�ļ���
    %filename2 = [time,'compare',num2str(i),'.png'];                       %compare�ļ���
    imwrite(image_target{i},filename1);                                    %�洢��ȡͼ��
    %imwrite(image_compare{i},filename2);                                  %�洢�Ƚ�ͼ��
end
%% �����϶��
[r,c] = size(BW{1});                                                       %��ȡBW�����С��Ϣ
targetsize = r * c;                                                         %��������������
for i = 1:n
    cereals(i) = length(find(BW{i}==1));                                   %ͼ���й���������
    porosity(i) = 1-(cereals(i)/targetsize)                                 %�����϶��
end
%% ��ʾͼ��
figure(1);                                                                 %��ȡ����λ��ͼ
for i = 1:n
    subplot(2,2,i);imshow(image_compare{i});
    title(num2str(i));
    hold on;
end
figure(2);                                                                 %��ȡ���ֻҶ�ͼ
for i = 1:n
    subplot(2,2,i);imshow(image_target{i});
    title(num2str(i));
    hold on;
end
figure(3);                                                                 %��ȡ���ֶ�ֵͼ
for i = 1:n
    subplot(2,2,i);imshow(BW{i});
    title(['ѹ��',num2str(i),'   ','��϶��',num2str(porosity(i))]);
    hold on;
end