clear,close all,clc;
% ������ͼ��ֳ�10*10��һ�ٸ����񣬷ֱ������ֵ�ָ��϶�ʼ��㣬֮�����ɿ�϶����ͼ��
% load image
image_rgb{1} = imread('E:\00_������Ŀ\01_ʵ����Ƭ\2018.07.08_�����ӷּ���ѹ��0-150��25kpÿ��\IMG_1597.JPG');
% convert to grayscale image
image_gray{1} = rgb2gray(image_rgb{1});
% image segmentation
image_gray{1} = flipud(image_gray{1});  %���·�תͼ��
image_gray{1} = image_gray{1}.';        %ͼ����Ҫ��תʱʹ�ô�����ת�þ���
figure(1);
imshow(image_gray{1});
[x,y] = ginput(2);
close;                                         % close the current figure window
x(:) = fix(x(:)); y(:) = fix(y(:));                       %ȡ��
m(1) = 1;
% m(11) = x(2)-x(1);
n(1) = 1;
% n(11) = y(2)-y(1);
for i = 2:11
    m(i) = 1+(i-1)*fix((x(2)-x(1))/10);                 %������������
    n(i) = 1+(i-1)*fix((y(2)-y(1))/10);
end
image_target = image_gray{1}(y(1):y(1)+n(11)-n(1)-1,x(1):x(1)+m(11)-m(1)-1);
% calculating porosity
% plan A use every part to calculate
% for i = 1:10
%     for j = 1:10
%         image_target{i,j} = image_gray{1}(n(i):n(i+1),m(j):m(j+1));
%         T(i,j) = graythresh(image_target{i,j});
%         BW{i,j} = imbinarize(image_target{i,j});
%         [r(i,j),c(i,j)] = size(image_gray{1}(n(i):n(i+1),m(j):m(j+1)));
%         targetsize(i,j) = r(i,j)*c(i,j);
%         cereals(i,j) = length(find(BW{i,j}==1));
%         porosity(i,j) = 1-(cereals(i,j)/targetsize(i,j);
%     end
% end
% plan B use full image to calculate
for i = 1:10
    for j = 1:10
        T(i,j) = graythresh(image_target(n(i):n(i+1)-1,m(j):m(j+1)-1));
        BW_full(n(i):n(i+1)-1,m(j):m(j+1)-1) = imbinarize(image_target(n(i):n(i+1)-1,m(j):m(j+1)-1),T(i,j));
        [r(i,j),c(i,j)] = size(BW_full(n(i):n(i+1)-1,m(j):m(j+1)-1));
        targetsize(i,j) = r(i,j)*c(i,j);
        cereals(i,j) = length(find(BW_full(n(i):n(i+1)-1,m(j):m(j+1)-1))==1);
        porosity(i,j) = 1-(cereals(i,j)/targetsize(i,j));
    end
end
% drawing a grid on BW_full
for i = 2:11                                                      %caution : this code could mislead the result
    BW_full(m(i),:) = 0; BW_full(m(i)-1,:) = 0;
    BW_full(:,n(i)) = 0; BW_full(:,n(i)-1) = 0;
end
figure(2);imshow(BW_full);
% for i = 1:10
%     for j = 1:10 
%         str1{i,j} = ['��϶��',num2str(porosity(i,j))];     % put label
%         text(m(i)+20,n(j)+20,str1(i,j),'color','red');    % put label
%     end
% end
figure(3);
colormap('hot');     %set map color
imagesc(porosity);   %draw with matrix,�þ����ͼ
saveas(figure(3),'�����ӿ�϶�ֲ�ͼ.png');
colorbar;