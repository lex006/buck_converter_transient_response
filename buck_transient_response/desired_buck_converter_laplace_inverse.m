% 定义传递函数变量 s
s = tf('s');

% 使用 Pade 近似来处理延迟，这是因为e的次方项存在
delay1 = pade(exp(-5e-6 * s), 10);  % 5 微秒延迟的 10 阶 Pade 近似
delay2 = pade(exp(-10e-6 * s), 10); % 10 微秒延迟的 10 阶 Pade 近似

% 根据手算的公式定义 Y(s)，此处L=80mH,C=3.5uF,R=150ohm,参数可调
Y1 = (6/s) * (delay1 - 1) / (delay2 - 1);
Y2 = 150 / (150 + 0.08*s + 4.2e-5 * s^2);
Y = Y1 * Y2;

% 设置时间范围
t = 0:1e-6:10e-3; % 选择合适的时间范围，以微秒为间隔，直到 50 毫秒

% 计算脉冲响应以获得 y(t)
[y_t, t] = impulse(Y, t); 

% 绘制图像
plot(t, y_t);
xlabel('Time (t) [seconds]')
ylabel('y(t)')
title('Numerical Inverse Laplace Transform of Y(s) with Pade Approximation')
grid on