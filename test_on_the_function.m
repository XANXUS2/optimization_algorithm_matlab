
%% 均值，最优值，最差值，标准差，wilcoxon秩和检验

clear all 
clc

%% 参数设置
Function_name='F1'; %  设定适应度函数（基准函数F1~F23）
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);  % 加载所选基准函数

SearchAgents_no=30; % 种群数量
Max_iteration=500; %  设定最大迭代次数

%% 进行30次实验，统计结果
for i = 1:30
    disp(['第',num2str(i),'次实验']);
    % GWO 灰狼优化算法
    [GWO_score(i),GWO_pos(i,:),GWO_curve(i,:)]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % WOA 鲸鱼优化算法
    [WOA_score(i),WOA_pos(i,:),WOA_curve(i,:)]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % SCA 正余弦优化算法
    [SCA_score(i),SCA_pos(i,:),SCA_curve(i,:)]=SCA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % BWO 白鲸优化算法
    [BWO_pos(i,:),BWO_score(i,:),BWO_curve(i,:)]=BWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % COA 布谷鸟优化算法
    [COA_score(i,:),COA_pos(i,:),COA_curve(i,:)]=COA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % NRBO 牛顿-拉夫逊法优化算法
    [NRBO_score(i,:),NRBO_pos(i,:),NRBO_curve(i,:)]=NRBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % PSO 粒子群优化算法
    [PSO_pos(i,:),PSO_score(i,:),PSO_curve(i,:)]=PSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % DBO 蜣螂优化算法
    [DBO_score(i,:),DBO_pos(i,:),DBO_curve(i,:)]=DBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化
    % Chimp 黑猩猩优化算法ChOA
    [ChOA_score(i,:),ChOA_pos(i,:),ChOA_curve(i,:)]=Chimp(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %开始优化 
end

%% 结果对比
figure('Position',[269   240   660   290]) % 设置图形窗口位置和大小

%搜索空间
subplot(1,2,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

% 绘制平均值的曲线
subplot(1,2,2);
semilogy(mean(GWO_curve),'Color','g','linewidth',1.5)
hold on
semilogy(mean(WOA_curve),'Color','m','linewidth',1.5)
hold on
semilogy(mean(SCA_curve),'Color','b','linewidth',1.5)
hold on
semilogy(mean(BWO_curve),'Color','k','linewidth',1.5)
hold on
semilogy(mean(COA_curve),'Color','c','linewidth',1.5)
hold on
semilogy(mean(NRBO_curve),'Color',[0.1,0.2,0.5],'linewidth',1.5) % RGB值归一化到0~1之间
hold on
semilogy(mean(PSO_curve),'Color',[0.5,0.2,0.8],'linewidth',1.5)
hold on
semilogy(mean(DBO_curve),'Color',[0,0.5,0.5],'linewidth',1.5)
hold on
semilogy(mean(ChOA_curve),'Color',[0.5,0,0.5],'linewidth',1.5)
hold on

title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
legend('GWO','WOA','SCA','BWO','COA','NRBO','PSO','DBO','ChOA')

disp('-------------------------------------------------')
display(['GWO算法30次实验最优适应度值(Best) : ', num2str(min(GWO_score))]);
display(['GWO算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(GWO_score))]);
display(['GWO算法30次实验最差适应度值(wrost) : ', num2str(max(GWO_score))]);
display(['GWO算法30次实验标准差（std） : ', num2str(std(GWO_score))]);

disp('-------------------------------------------------')
display(['WOA算法30次实验最优适应度值(Best) : ', num2str(min(WOA_score))]);
display(['WOA算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(WOA_score))]);
display(['WOA算法30次实验最差适应度值(wrost) : ', num2str(max(WOA_score))]);
display(['WOA算法30次实验标准差（std） : ', num2str(std(WOA_score))]);

disp('-------------------------------------------------')
display(['SCA算法30次实验最优适应度值(Best) : ', num2str(min(SCA_score))]);
display(['SCA算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(SCA_score))]);
display(['SCA算法30次实验最差适应度值(wrost) : ', num2str(max(SCA_score))]);
display(['SCA算法30次实验标准差（std） : ', num2str(std(SCA_score))]);

disp('-------------------------------------------------')
display(['COA算法30次实验最优适应度值(Best) : ', num2str(min(COA_score))]);
display(['COA算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(COA_score))]);
display(['COA算法30次实验最差适应度值(wrost) : ', num2str(max(COA_score))]);
display(['COA算法30次实验标准差（std） : ', num2str(std(COA_score))]);

disp('-------------------------------------------------')
display(['NRBO算法30次实验最优适应度值(Best) : ', num2str(min(NRBO_score))]);
display(['NRBO算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(NRBO_score))]);
display(['NRBO算法30次实验最差适应度值(wrost) : ', num2str(max(NRBO_score))]);
display(['NRBO算法30次实验标准差（std） : ', num2str(std(NRBO_score))]);

disp('-------------------------------------------------')
display(['PSO算法30次实验最优适应度值(Best) : ', num2str(min(PSO_score))]);
display(['PSO算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(PSO_score))]);
display(['PSO算法30次实验最差适应度值(wrost) : ', num2str(max(PSO_score))]);
display(['PSO算法30次实验标准差（std） : ', num2str(std(PSO_score))]);

disp('-------------------------------------------------')
display(['DBO算法30次实验最优适应度值(Best) : ', num2str(min(DBO_score))]);
display(['DBO算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(DBO_score))]);
display(['DBO算法30次实验最差适应度值(wrost) : ', num2str(max(DBO_score))]);
display(['DBO算法30次实验标准差（std） : ', num2str(std(DBO_score))]);

disp('-------------------------------------------------')
display(['ChOA算法30次实验最优适应度值(Best) : ', num2str(min(ChOA_score))]);
display(['ChOA算法30次实验最优解对应的平均适应度值(mean) : ', num2str(mean(ChOA_score))]);
display(['ChOA算法30次实验最差适应度值(wrost) : ', num2str(max(ChOA_score))]);
display(['ChOA算法30次实验标准差（std） : ', num2str(std(ChOA_score))]);

%% wilcoxon秩和检验
[p1,h1] = ranksum(GWO_score,BWO_score,'alpha', 0.05);
disp(['GWO-BWO-wilcoxon秩和检验：检验p值为：',num2str(p1)]);

[p2,h2] = ranksum(WOA_score,BWO_score,'alpha', 0.05);
disp(['WOA-BWO-wilcoxon秩和检验：检验p值为：',num2str(p2)]);

[p3,h3] = ranksum(SCA_score,BWO_score,'alpha', 0.05);
disp(['SCA-BWO-wilcoxon秩和检验：检验p值为：',num2str(p3)]);

[p4,h4] = ranksum(COA_score,BWO_score,'alpha', 0.05);
disp(['COA-BWO-wilcoxon秩和检验：检验p值为：',num2str(p4)]);

[p5,h5] = ranksum(NRBO_score,BWO_score,'alpha', 0.05);
disp(['NRBO-BWO-wilcoxon秩和检验：检验p值为：',num2str(p5)]);

[p6,h6] = ranksum(PSO_score,BWO_score,'alpha', 0.05);
disp(['PSO-BWO-wilcoxon秩和检验：检验p值为：',num2str(p6)]);

[p7,h7] = ranksum(DBO_score,BWO_score,'alpha', 0.05);
disp(['DBO-BWO-wilcoxon秩和检验：检验p值为：',num2str(p7)]);

[p8,h8] = ranksum(ChOA_score,BWO_score,'alpha', 0.05);
disp(['ChOA-BWO-wilcoxon秩和检验：检验p值为：',num2str(p8)]);
