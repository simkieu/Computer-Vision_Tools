clear
clc
load('M.mat')

Q = M(:,1:3);
m_4 = M(:,4);
C = -Q\m_4;
C = C'

% %Test to debug using M_normalized
% M_test = [-0.4583 0.2947 0.0139 -0.0040;
% 0.0509 0.0546 0.5410 0.0524;
% -0.1090 -0.1784 0.0443 -0.5968];
% Q = M_test(:,1:3);
% m_4 = M_test(:,4);
% C_test = -Q\m_4;
% C_test = C_test'
