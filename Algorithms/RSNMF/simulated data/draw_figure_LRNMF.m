% ª≠ ‰»Î‘Î…˘”Îπ¿º∆‘Î…˘«˙œﬂ 1 stands for L1/2 method and 2 stands for L1 method
%% experiment 1 parameter analysis for L1RNMF. SNR =30; ratio=0.2, and sp =2
x2 = [0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4, 2.6];
RMSE2=[0.193733557, 0.158171766, 0.137713294, 0.131486674, 0.119285296,...
       0.095804237, 0.086370711, 0.090720225, 0.091028661, 0.094100101, 0.097085939, 0.107772274, 0.115821935];
SAD2=[0.227970598, 0.19881151, 0.173252056, 0.154857548, 0.149397721, 0.132093004,...
    0.127743034, 0.137367722, 0.14075942, 0.141522654, 0.152839982, 0.177962853, 0.177997237];
RMSE_stand = 0.132823581 * ones(1,13);
SAD_stand  = 0.20481762  * ones(1,13);

figure(1) % RMSE of L1RNMF 
hold on
plot(x2,RMSE2,'b','LineWidth',3);
plot(x2,RMSE_stand,'r','LineWidth',3);
xlabel('\lambda', 'FontName', 'Times New Roman','FontSize',18);
ylabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.2 2.6 0.06 0.22])
set(gca,'ytick',[0.06,0.09,0.12,0.15,0.18, 0.21,0.24],'yticklabel',[0.06,0.09,0.12,0.15,0.18, 0.21,0.24]);
set(gca,'xtick',[0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9],'xticklabel',[0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9]);
box on
set(gcf,'Position',[200 200 520 440]);

figure(2) % SAD of L1RNMF 
hold on
plot(x2,SAD2,'b','LineWidth',3);
plot(x2,SAD_stand,'r','LineWidth',3);
xlabel('\lambda', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.2 2.6 0.12 0.25])
set(gca,'ytick',[0.12,0.15,0.18,0.21,0.24, 0.27],'yticklabel',[0.12,0.15,0.18,0.21,0.24, 0.27]);
set(gca,'xtick',[0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9],'xticklabel',[0.1,0.5,0.9,1.3,1.7,2.1,2.5,2.9]);
box on
set(gcf,'Position',[200 200 520 440]);

%% experiment 1 parameter analysis for L1/2_RNMF. SNR =30; ratio=0.2, and sp =2
x1 = [0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2, 4.4];
RMSE1=[0.181132523, 0.151025865, 0.144383786, 0.143404686, 0.130286294, 0.128152634, 0.117859769, 0.11769678, 0.114339994, 0.103377233, 0.100563047,...
       0.100574346, 0.09360811, 0.088547451, 0.086830866, 0.081731044, 0.09179056, 0.092588379, 0.096517595, 0.100479319, 0.103474276, 0.108896192]; 
SAD1=[0.25301873, 0.227458669, 0.204873086, 0.19099302, 0.168761623, 0.15640338, 0.146832523, 0.136450981, 0.122944254, 0.115647309, 0.115352715,...
      0.107621578, 0.106819183, 0.10488506, 0.085812172, 0.088252735, 0.092770417, 0.09255981, 0.093010557, 0.094101519093, 0.0951017400566, 0.1015763946];
RMSE1_stand = 0.127830737 * ones(1,22);
SAD1_stand  = 0.123855281 * ones(1,22);

figure(3) % RMSE of L1/2_RNMF 
hold on
plot(x1,RMSE1,'b','LineWidth',3);
plot(x1,RMSE1_stand,'r','LineWidth',3);
xlabel('\lambda', 'FontName', 'Times New Roman','FontSize',18);
ylabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.2 4.4 0.06 0.22])
set(gca,'ytick',[0.06,0.09,0.12,0.15,0.18, 0.21,0.24],'yticklabel',[0.06,0.09,0.12,0.15,0.18, 0.21,0.24]);
set(gca,'xtick',[0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5],'xticklabel',[0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5]);
box on
set(gcf,'Position',[200 200 520 440]);

figure(4) % SAD of L1/2_RNMF 
hold on
plot(x1,SAD1,'b','LineWidth',3);
plot(x1,SAD1_stand,'r','LineWidth',3);
xlabel('\lambda', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.2 4.4 0.06 0.22])
set(gca,'ytick',[0.06,0.09,0.12,0.15,0.18, 0.21,0.24],'yticklabel',[0.06,0.09,0.12,0.15,0.18, 0.21,0.24]);
set(gca,'xtick',[0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5],'xticklabel',[0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5]);
box on
set(gcf,'Position',[200 200 520 440]);

%% experiment 2 Robustness to Gaussian noise K=4, ratio=0.2, and sp =0.2. SNR=40,30,20,and 10.
RMSE_NMF1 = [0.113654441, 0.114830737, 0.123880584, 0.159129649];
SAD_NMF1  = [0.114873882, 0.123855281, 0.128463552, 0.14590025];
RMSE_NMF2 = [0.127590915, 0.132823581, 0.134191358, 0.165541479];
SAD_NMF2  = [0.171497131, 0.184817620, 0.206108099, 0.215267846];
RMSE_RNMF1 = [0.081207385, 0.081812172, 0.092817601, 0.121350018];
SAD_RNMF1  = [0.07970456,  0.082830866, 0.094031119, 0.125619896];
RMSE_RNMF2 = [0.085496968, 0.086370711, 0.102034687, 0.135125642];
SAD_RNMF2  = [0.136948004, 0.137367722, 0.141128526, 0.165524895];
x = [10, 20, 30, 40];

% SAD 
figure(5)
hold on
plot(x,SAD_NMF2,'r','LineWidth',3);
plot(x,SAD_RNMF2,'r','LineWidth',3);
plot(x,SAD_NMF1,'b','LineWidth',3);
plot(x,SAD_RNMF1,'b','LineWidth',3);
xlabel('SNR', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([10 40 0.05 0.30])
set(gca,'ytick',[0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[10, 20, 30, 40],'xticklabel',[40, 30, 20, 10]);
box on
set(gcf,'Position',[200 200 520 440]);

% RMSE
figure(6)
hold on
plot(x,RMSE_NMF2,'r','LineWidth',3);
plot(x,RMSE_RNMF2,'r','LineWidth',3);
plot(x,RMSE_NMF1,'b','LineWidth',3);
plot(x,RMSE_RNMF1,'b','LineWidth',3);
xlabel('SNR', 'FontName', 'Times New Roman','FontSize',18);
ylabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([10 40 0.08 0.18])
set(gca,'ytick',[0.08,0.10,0.12,0.14,0.16,0.18],'yticklabel',[0.08,0.10,0.12,0.14,0.16,0.18]);
set(gca,'xtick',[10, 20, 30, 40],'xticklabel',[40, 30, 20, 10]);
box on
set(gcf,'Position',[200 200 520 440]);

%% experiment 3 Robustness to sparse noise K=4, SNR = 30, ratio=sp = 0, 0.1, 0.2, 0.3.
RMSE_NMF1 = [0.080849165, 0.103411871, 0.114830737, 0.131371221];
SAD_NMF1  = [0.086652499, 0.128534187, 0.123855281, 0.156687185];
RMSE_NMF2 = [0.087545935, 0.110446202, 0.132823581, 0.169497068];
SAD_NMF2  = [0.144284744, 0.174256842, 0.184817620, 0.200370616];
RMSE_RNMF1 = [0.08361605, 0.088328968, 0.081812172, 0.091951719];
SAD_RNMF1  = [0.08800904, 0.086415792, 0.082830866, 0.090297076];
RMSE_RNMF2 = [0.08993508, 0.087821135, 0.086370711, 0.093231318];
SAD_RNMF2  = [0.13527101, 0.133753551, 0.137367722, 0.149041713];
x = [0, 0.1, 0.2, 0.3];

% SAD 
figure(7)
hold on
plot(x,SAD_NMF2,'r','LineWidth',3);
plot(x,SAD_RNMF2,'r','LineWidth',3);
plot(x,SAD_NMF1,'b','LineWidth',3);
plot(x,SAD_RNMF1,'b','LineWidth',3);
xlabel('values of ratio and sp', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0 0.3 0.05 0.30])
set(gca,'ytick',[0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[0, 0.1, 0.2, 0.3],'xticklabel',[0, 0.1, 0.2, 0.3]);
box on
set(gcf,'Position',[200 200 520 440]);

% RMSE
figure(8)
hold on
plot(x,RMSE_NMF2,'r','LineWidth',3);
plot(x,RMSE_RNMF2,'r','LineWidth',3);
plot(x,RMSE_NMF1,'b','LineWidth',3);
plot(x,RMSE_RNMF1,'b','LineWidth',3);
xlabel('values of ratio and sp', 'FontName', 'Times New Roman','FontSize',18);
ylabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0 0.3 0.07 0.18])
set(gca,'ytick',[0.08,0.10,0.12,0.14,0.16,0.18],'yticklabel',[0.08,0.10,0.12,0.14,0.16,0.18]);
set(gca,'xtick',[0, 0.1, 0.2, 0.3],'xticklabel',[0, 0.1, 0.2, 0.3]);
box on
set(gcf,'Position',[200 200 520 440]);

%% experiment 4 generalization to different numbers of end-members k = 4, 5, 6, 7, 8.
RMSE_NMF1 = [ 0.103411871, 0.105893672, 0.121852289, 0.129688467, 0.138780087];
SAD_NMF1  = [ 0.128534187, 0.126764148, 0.136497518, 0.153991535, 0.153545255];
RMSE_NMF2 = [ 0.110446202, 0.118729116, 0.137071710, 0.143024452, 0.144978191];
SAD_NMF2  = [ 0.174256842, 0.183510522, 0.190999775, 0.199099966, 0.218382501];
RMSE_RNMF1 = [ 0.088328968, 0.091458911, 0.096064829, 0.111111316, 0.123554381];
SAD_RNMF1  = [ 0.086415792, 0.089803665, 0.091121779, 0.106849123, 0.111532674];
RMSE_RNMF2 = [ 0.087821135, 0.102445689, 0.105109017, 0.110601640, 0.128248347];
SAD_RNMF2  = [ 0.133753551, 0.146842164, 0.160422423, 0.185112532, 0.188568487];
x = [4, 5, 6, 7, 8];

% SAD 
figure(9)
hold on
plot(x,SAD_NMF2,'r','LineWidth',3);
plot(x,SAD_RNMF2,'r','LineWidth',3);
plot(x,SAD_NMF1,'b','LineWidth',3);
plot(x,SAD_RNMF1,'b','LineWidth',3);
xlabel('Number of endmembers', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([4 8 0.05 0.30])
set(gca,'ytick',[0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[4, 5, 6, 7, 8],'xticklabel',[4, 5, 6, 7, 8]);
box on
set(gcf,'Position',[200 200 520 440]);

% RMSE
figure(10)
hold on
plot(x,RMSE_NMF2,'r','LineWidth',3);
plot(x,RMSE_RNMF2,'r','LineWidth',3);
plot(x,RMSE_NMF1,'b','LineWidth',3);
plot(x,RMSE_RNMF1,'b','LineWidth',3);
xlabel('Number of endmembers', 'FontName', 'Times New Roman','FontSize',18);
ylabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([4 8 0.07 0.18])
set(gca,'ytick',[0.08,0.10,0.12,0.14,0.16,0.18],'yticklabel',[0.08,0.10,0.12,0.14,0.16,0.18]);
set(gca,'xtick',[4, 5, 6, 7, 8],'xticklabel',[4, 5, 6, 7, 8]);
box on
set(gcf,'Position',[200 200 520 440]);

%% real data experiment
% reference siginatures selected from the library [1,6,15,16]
load ('urban_lib_resampling');
x = urban_lib_resampling(:,1); % spectra information
% Band162=[5:75,77:86,88:100,112:135,154:197];
figure(11)
hold on
plot(x,urban_lib_resampling(:,2),'r','LineWidth',2);
plot(x,urban_lib_resampling(:,7),'g','LineWidth',2);
plot(x,urban_lib_resampling(:,16),'b','LineWidth',2);
plot(x,urban_lib_resampling(:,17),'m','LineWidth',2);
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);

%% draw the curve in the interval of noisy-free part
load ('urban_lib_resampling');
x = urban_lib_resampling(:,1); % spectra information
% reference siginatures selected from the library [1,6,15,16] or [4, 6, 15, 18]
% Band162=[5:75,77:86,88:100,112:135,154:197];
figure(12)
hold on
% for legend
y=urban_lib_resampling(:,5);
plot(x(5:75),y(5:75),'r','LineWidth',3);
y=urban_lib_resampling(:,7);
plot(x(5:75),y(5:75),'g','LineWidth',3);
y=urban_lib_resampling(:,16);
plot(x(5:75),y(5:75),'b','LineWidth',3);
y=urban_lib_resampling(:,19);
plot(x(5:75),y(5:75),'m','LineWidth',3);

mypartfunction(x, urban_lib_resampling(:,5),1, 'r', 3 );
mypartfunction(x, urban_lib_resampling(:,7),1, 'g', 3 );
mypartfunction(x, urban_lib_resampling(:,16),1, 'b', 3 );
mypartfunction(x, urban_lib_resampling(:,19),1, 'm', 3 );
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('Asphalt','Grass','Roof','Tree','location','northwest')

% The result of Robust SNMF for noisy-free data (B162)
load ('B162_RL1_2_Aest');
A_est_SRNMF = zeros(210,4);
A_est_SRNMF([5:75,77:86,88:100,112:135,154:197],:) = A_SRNMF;
% reference siginatures selected from the library [1,6,15,16]
% Band162=[5:75,77:86,88:100,112:135,154:197];
figure(13)
hold on
% for legend
y=A_est_SRNMF(:,1);
plot(x(5:75),y(5:75),'r','LineWidth',3);
y=A_est_SRNMF(:,2);
plot(x(5:75),y(5:75),'g','LineWidth',3);
y=A_est_SRNMF(:,3);
plot(x(5:75),y(5:75),'b','LineWidth',3);
y=A_est_SRNMF(:,4);
plot(x(5:75),y(5:75),'m','LineWidth',3);

mypartfunction(x, A_est_SRNMF(:,1),1, 'r', 3 );
mypartfunction(x, A_est_SRNMF(:,2),1, 'g', 3 );
mypartfunction(x, A_est_SRNMF(:,3),1, 'b', 3 );
mypartfunction(x, A_est_SRNMF(:,4),1, 'm', 3 );
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('Asphalt','Grass','Roof','Tree','location','northwest')

% The result of SNMF for noisy-free data (B162)
load ('B162_L1_2_Aest');
A_est_SNMF = zeros(210,4);
A_est_SNMF([5:75,77:86,88:100,112:135,154:197],:) = A_SNMF;
% reference siginatures selected from the library [1,6,15,16]
% Band162=[5:75,77:86,88:100,112:135,154:197];
figure(14)
hold on
% for legend
y=A_est_SNMF(:,1);
plot(x(5:75),y(5:75),'r','LineWidth',3);
y=A_est_SNMF(:,2);
plot(x(5:75),y(5:75),'g','LineWidth',3);
y=A_est_SNMF(:,3);
plot(x(5:75),y(5:75),'b','LineWidth',3);
y=A_est_SNMF(:,4);
plot(x(5:75),y(5:75),'m','LineWidth',3);

mypartfunction(x, A_est_SNMF(:,1),1, 'r', 3 );
mypartfunction(x, A_est_SNMF(:,2),1, 'g', 3 );
mypartfunction(x, A_est_SNMF(:,3),1, 'b', 3 );
mypartfunction(x, A_est_SNMF(:,4),1, 'm', 3 );
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('Asphalt','Grass','Roof','Tree','location','northwest')

%% draw the curve in the interval of noisy-free and noisy part
load ('urban_lib_resampling');
x = urban_lib_resampling(:,1); % spectra information
% reference siginatures selected from the library [1,6,15,16] or [4, 6, 15, 18]
% Band189=[1:104,110:138,152:207];
figure(15)
hold on
% for legend
y=urban_lib_resampling(:,5);
plot(x(5:75),y(5:75),'r','LineWidth',3);
y=urban_lib_resampling(:,7);
plot(x(5:75),y(5:75),'g','LineWidth',3);
y=urban_lib_resampling(:,16);
plot(x(5:75),y(5:75),'b','LineWidth',3);
y=urban_lib_resampling(:,19);
plot(x(5:75),y(5:75),'m','LineWidth',3);

mypartfunction(x, urban_lib_resampling(:,5),2, 'r', 3 );
mypartfunction(x, urban_lib_resampling(:,7),2, 'g', 3 );
mypartfunction(x, urban_lib_resampling(:,16),2, 'b', 3 );
mypartfunction(x, urban_lib_resampling(:,19),2, 'm', 3 );
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('Asphalt','Grass','Roof','Tree','location','northwest')

% The result of Robust SNMF for noisy-free data (B162)
load ('B189_RL1_2_Aest');
A_est_SRNMF = zeros(210,4);
A_est_SRNMF([1:104,110:138,152:207],:) = A_SRNMF;
% reference siginatures selected from the library [1,6,15,16]
% Band162=[5:75,77:86,88:100,112:135,154:197];
figure(16)
hold on
% for legend
y=A_est_SRNMF(:,1);
plot(x(5:75),y(5:75),'r','LineWidth',3);
y=A_est_SRNMF(:,2);
plot(x(5:75),y(5:75),'g','LineWidth',3);
y=A_est_SRNMF(:,3);
plot(x(5:75),y(5:75),'b','LineWidth',3);
y=A_est_SRNMF(:,4);
plot(x(5:75),y(5:75),'m','LineWidth',3);

mypartfunction(x, A_est_SRNMF(:,1),2, 'r', 3 );
mypartfunction(x, A_est_SRNMF(:,2),2, 'g', 3 );
mypartfunction(x, A_est_SRNMF(:,3),2, 'b', 3 );
mypartfunction(x, A_est_SRNMF(:,4),2, 'm', 3 );
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('Asphalt','Grass','Roof','Tree','location','northwest')

% The result of SNMF for noisy-free data (B162)
load ('B189_L1_2_Aest');
A_est_SNMF = zeros(210,4);
A_est_SNMF([1:104,110:138,152:207],:) = A_SNMF;
% reference siginatures selected from the library [1,6,15,16]
% Band162=[1:104,110:138,152:207];
figure(17)
hold on
% for legend
y=A_est_SNMF(:,1);
plot(x(5:75),y(5:75),'r','LineWidth',3);
y=A_est_SNMF(:,2);
plot(x(5:75),y(5:75),'g','LineWidth',3);
y=A_est_SNMF(:,3);
plot(x(5:75),y(5:75),'b','LineWidth',3);
y=A_est_SNMF(:,4);
plot(x(5:75),y(5:75),'m','LineWidth',3);

mypartfunction(x, A_est_SNMF(:,1),2, 'r', 3 );
mypartfunction(x, A_est_SNMF(:,2),2, 'g', 3 );
mypartfunction(x, A_est_SNMF(:,3),2, 'b', 3 );
mypartfunction(x, A_est_SNMF(:,4),2, 'm', 3 );
xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('Asphalt','Grass','Roof','Tree','location','northwest')

%% experiment in the review Robustness to sparse noise K=4, SNR = 30, ratio=sp = 0, 0.1, 0.2, 0.3.
%  method RNMF1 NMF1 and median filter with NMF1
RMSE_NMF1 = [0.0808, 0.1034, 0.1148, 0.1313];
SAD_NMF1  = [0.0866, 0.1285, 0.1238, 0.1566];
RMSE_MNMF1 = [0.0975, 0.1014, 0.1093, 0.1204];
SAD_MNMF1  = [0.1004, 0.1075, 0.1282, 0.1331];
RMSE_RNMF1 = [0.083, 0.0883, 0.0818, 0.09195];
SAD_RNMF1  = [0.088, 0.0864, 0.0828, 0.09030];

x = [0, 0.1, 0.2, 0.3];

% SAD 
figure(18)
hold on
plot(x,SAD_MNMF1,'r','LineWidth',3);
plot(x,SAD_NMF1,'b','LineWidth',3);
plot(x,SAD_RNMF1,'b','LineWidth',3);
xlabel('values of ratio and sp', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0 0.3 0.05 0.30])
set(gca,'ytick',[0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[0, 0.1, 0.2, 0.3],'xticklabel',[0, 0.1, 0.2, 0.3]);
box on
set(gcf,'Position',[200 200 520 440]);

% RMSE
figure(19)
hold on
plot(x,RMSE_MNMF1,'r','LineWidth',3);
plot(x,RMSE_NMF1,'b','LineWidth',3);
plot(x,RMSE_RNMF1,'b','LineWidth',3);
xlabel('values of ratio and sp', 'FontName', 'Times New Roman','FontSize',18);
ylabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0 0.3 0.07 0.18])
set(gca,'ytick',[0.08,0.10,0.12,0.14,0.16,0.18],'yticklabel',[0.08,0.10,0.12,0.14,0.16,0.18]);
set(gca,'xtick',[0, 0.1, 0.2, 0.3],'xticklabel',[0, 0.1, 0.2, 0.3]);
box on
set(gcf,'Position',[200 200 520 440]);


%% SADall with related to parameter lambda=[0,0.5,1,3,5,7] and delta = [0,5,10,15,20,25]
% L1/2-RNMF
lambda=[0,0.5,1,3,5,7];gamma=[0,0.5,1,3,5,7]; delta = [0,5,10,15,20,25];
RMSEall = [0.0949    0.0921    0.0855    0.1330    0.1339    0.1339
 0.1314    0.0857    0.0869    0.1329    0.1335    0.1339
 0.2310    0.0595    0.1067    0.1325    0.1319    0.1357
 0.2726    0.0659    0.1296    0.1341    0.1321    0.1437
 0.2902    0.1292    0.1517    0.1399    0.1378    0.1554
 0.2995    0.1915    0.1691    0.1519    0.1490    0.1764];
SADall=[0.1654	0.1570	0.1141	0.1095	0.1063	0.1022
0.1482	0.1422	0.1017	0.104	0.1021	0.0983
0.0873	0.0803	0.0719	0.0855	0.0871	0.0839
0.0477	0.0545	0.0662	0.0712	0.0734	0.0732
0.0464	0.1071	0.0722	0.0683	0.0689	0.0769
0.0503	0.1125	0.0763	0.0703	0.0722	0.0870];
figure(20)
mesh(gamma,delta,SADall);
xlabel('q values', 'FontName', 'Times New Roman','FontSize',18,'rotation',15);
ylabel('\delta values', 'FontName', 'Times New Roman','FontSize',18,'rotation',-25);
zlabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
axis([0 7 0 30 0 0.2]);
set(gca,'ztick',[0,0.05,0.10,0.15,0.20],'yticklabel',[0,0.05,0.10,0.15,0.20]);
set(gca,'xtick',[0, 2, 4, 6],'xticklabel',[0, 2, 4, 6]);
set(gca,'ytick',[0, 5, 10, 15, 20, 25],'yticklabel',[0, 5, 10, 15, 20, 25]);

figure(21)
mesh(lambda,delta,RMSEall);
xlabel('q values', 'FontName', 'Times New Roman','FontSize',18);
ylabel('\delta values', 'FontName', 'Times New Roman','FontSize',18);
zlabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
axis([0 7 0 30 0 0.3]);
set(gca,'ztick',[0,0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0,0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[0, 2, 4, 6],'xticklabel',[0, 2, 4, 6]);
set(gca,'ytick',[0, 5, 10, 15, 20, 25],'yticklabel',[0, 5, 10, 15, 20, 25]);
% L1-RNMF
RMSEall = [0.094853958	0.092126021	0.085548423	0.133019097	0.133942957	0.133919886
0.134079751	0.092180629	0.085554971	0.133019257	0.133943374	0.133919748
0.222624776	0.092401089	0.085581428	0.133019927	0.133945055	0.133919201
0.259239548	0.092681194	0.085615087	0.133020826	0.133947177	0.133918528
0.27568339	0.092966305	0.0856494	0.133021794	0.133949323	0.133917868
0.285010875	0.093256381	0.085684365	0.133022829	0.133951493	0.133917222];

SADall  =  [0.165435712	0.157018453	0.114058714	0.109497691	0.106280316	0.102176028
0.164095758	0.157038029	0.114062514	0.10949726	0.106280231	0.102176737
0.160930719	0.157116284	0.11407772	0.109495532	0.106279894	0.10217957
0.158630118	0.157213929	0.114096733	0.109493369	0.106279471	0.102183109
0.156966095	0.157311412	0.114115759	0.109491202	0.106279049	0.102186645
0.155606119	0.157408732	0.114134794	0.109489032	0.106278626	0.102190176];
figure(22)
mesh(gamma,delta,SADall);
xlabel('q values', 'FontName', 'Times New Roman','FontSize',18);
ylabel('\delta values', 'FontName', 'Times New Roman','FontSize',18);
zlabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
axis([0 7 0 30 0 0.2]);
set(gca,'ztick',[0,0.05,0.10,0.15,0.20],'yticklabel',[0,0.05,0.10,0.15,0.20]);
set(gca,'xtick',[0, 2, 4, 6],'xticklabel',[0, 2, 4, 6]);
set(gca,'ytick',[0, 5, 10, 15, 20, 25],'yticklabel',[0, 5, 10, 15, 20, 25]);

figure(23)
mesh(gamma,delta,RMSEall);
xlabel('q values', 'FontName', 'Times New Roman','FontSize',18);
ylabel('\delta values', 'FontName', 'Times New Roman','FontSize',18);
zlabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
axis([0 7 0 30 0 0.3]);
set(gca,'ztick',[0,0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0,0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[0, 2, 4, 6],'xticklabel',[0, 2, 4, 6]);
set(gca,'ytick',[0, 5, 10, 15, 20, 25],'yticklabel',[0, 5, 10, 15, 20, 25]);

%% draw figure (2) a.(125,191) blue  b.(132,211) red  c.(122,237) green
load ('urban_lib_resampling');
x = urban_lib_resampling(:,1); % spectra information
a = reshape(urban(125,191,:),210,1);
b = reshape(urban(132,211,:),210,1);
c = reshape(urban(122,237,:),210,1);

a1 = zeros(210,1);
a1([5:75,77:86,88:100,112:135,154:197],1) = a([5:75,77:86,88:100,112:135,154:197],1);
b1 = zeros(210,1);
b1([5:75,77:86,88:100,112:135,154:197],1) = b([5:75,77:86,88:100,112:135,154:197],1);
c1 = zeros(210,1);
c1([5:75,77:86,88:100,112:135,154:197],1) = c([5:75,77:86,88:100,112:135,154:197],1);

figure(100)
hold on
% for legend

plot(x(5:75),a1(5:75),'b','LineWidth',2);
plot(x(5:75),b1(5:75),'r','LineWidth',2);
plot(x(5:75),c1(5:75),'g','LineWidth',2);

mypartfunction(x, a1,1, 'b', 2 );
mypartfunction(x, b1,1, 'r', 2 );
mypartfunction(x, c1,1, 'g', 2 );

xlabel('\lambda(\mum)', 'FontName', 'Times New Roman','FontSize',18);
ylabel('reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([0.4 2.5 0 0.4])
% set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
% set(gca,'xtick',[0.5, 1.0, 1.5, 2.0, 2.5],'xticklabel',[0.5, 1.0, 1.5, 2.0, 2.5]);
box on
set(gcf,'Position',[200 200 520 440]);
legend('1','2','3','location','northwest')





