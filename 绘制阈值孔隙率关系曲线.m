%% 阈值孔隙率关系曲线
% 读取转灰度
% 截取图像
% 计算阈值-孔隙率
% 绘图
% #读取图像
image_rgb = imread('E:\00_公益项目\01_实验照片\2018.01-03_压缩实验\IMG_1301.JPG');
image_gray = rgb2gray(image_rgb);
% #截取图像
imshow(image_gray);
[x,y] = ginput(2)
x(:) = round(x(:));                                                        %坐标取整数，四舍五入到最近整数
y(:) = round(y(:));
image_target = image_gray(y(1):y(2),x(1):x(2));
% #计算阈值-孔隙率
[r,c] = size(image_target);
targetsize = r * c;
for i = 1:255
    T(i) = i/256;
    BW{i} = im2bw(image_target,T(i));
    porosity(i) = length(find(BW{i}==0)) / targetsize;
end
plot(porosity);
