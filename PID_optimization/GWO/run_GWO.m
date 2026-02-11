clear
clc

Population=50; %  种群数量
MaxIt=100; % 最大迭代次数
dim = 3; % 参数维度，3个参数（KP、KI、KD）

fobj = @PID_fitness; % 适应度函数

% 范围
UB = 300; % 最大值
LB = 0; % 最小值

loop = 100; % 循环次数

tic;
parfor i = 1:loop
    disp(['第',num2str(i),'次实验']);
	tic;
    [GWO_score(i),GWO_pos(i,:),GWO_curve(i,:)]=GWO(Population,MaxIt,LB,UB,dim,fobj);
	toc;
end
toc;
disp('Done');

%% 打印最优参数
[minValue, minIndex] = min(GWO_score);
disp('-------------------------------------------------')
display(['最优适应度值(Best) : ',  num2str(minValue)]);
PID_best_data = GWO_pos(minIndex,:);
disp('最优参数值：')
disp(['KP: ', num2str(PID_best_data(1))]);
disp(['KI: ', num2str(PID_best_data(2))]);
disp(['KD: ', num2str(PID_best_data(3))]);
disp('-------------------------------------------------')

%% 保存数据
% 用时间戳命名
formattedTime = datestr(now,'yyyymmddHH');
randomString = upper(char('A'+ randi(26,1,2))-1);
name = ['GWO_',num2str(loop),'_',formattedTime, randomString, '.mat'];
save(name);
disp(name);
disp('Done');

%% 绘制结果

% 最优适应度值曲线
figure('Position',[269   240   660   290])
plot(GWO_curve(minIndex, :), 'DisplayName', ['Curve ' num2str(i)]);
xlabel('迭代次数', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('适应度值', 'FontSize', 12, 'FontWeight', 'bold');
title('适应度值变化曲线');

% 适应度平均值
figure('Position',[269   240   660   290])
plot(mean(GWO_curve),'Color','g','linewidth',1.5)
xlabel('迭代次数', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('适应度平均值', 'FontSize', 12, 'FontWeight', 'bold');
title('适应度平均值变化曲线')

% 所有适应度曲线
figure;  
legendLabels = cell(1, loop); % 初始化图例标签的cell数组 
hold on; % 保持当前图形，以便在同一坐标轴上绘制多条曲线  
for i = 1:size(GWO_curve, 1)  
    % 绘制第i行的曲线  
    plot(GWO_curve(i, :), 'DisplayName', ['Curve ' num2str(i)]); % 使用DisplayName属性为每条曲线指定名称    
    legendLabels{i} = ['Curve ' num2str(i)];  
end  
xlabel('迭代次数', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('适应度值', 'FontSize', 12, 'FontWeight', 'bold');
legend('show'); % 这将自动从DisplayName属性中获取图例标签  
hold off;