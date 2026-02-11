
function fitness = PID_fitness(x) % 适应度函数,输入为Kp,Ki,Kd, 输出为适应度函数值

assignin('base','Kp',x(1)); % 粒子依次赋值给Kp, 将x的第一个元素赋值给工作空间中的Kp
assignin('base','Ki',x(2)); % 粒子依次赋值给Kp, 将x的第二个元素赋值给工作空间中的Ki
assignin('base','Kd',x(3)); % 粒子依次赋值给Kp, 将x的第三个元素赋值给工作空间中的Kd

y_out =sim('PID_mode',[0,150]); % 运行名为'PID_mode'的Simulink模型，仿真时间为150秒
fitness = y_out.yout{1}.Values.Data(end,1); % 返回性能指标, 将输出向量y_out的最后一个元素（即最终输出）
end