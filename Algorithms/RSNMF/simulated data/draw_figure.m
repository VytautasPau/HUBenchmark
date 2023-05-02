%% draw figure
%% simulated experiment reference endmembers
figure(1)
load('signatures.mat')
plot(A(:,1:4));

xlabel('Band', 'FontName', 'Times New Roman','FontSize',18);
ylabel('Reflectance', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',9);
% set(gcf,'Position',[300 300 300 200]);
axis([0 250 0 1])
set(gca,'ytick',[0,0.2,0.4,0.6,0.8,1],'yticklabel',[0,0.2,0.4,0.6,0.8,1]);
set(gca,'xtick',[0, 50, 100, 150, 200,250],'xticklabel',[0, 50, 100,150,200,250]);
box on
set(gcf,'Position',[200 200 520 440]);
% legend('Asphalt','Grass','Roof','Tree','location','northwest')
legend('Carnallite NMNH98011','Ammonioalunite NMNH145596','Biotite HS28.3B','Actinolite NMNHR16485','location','northwest')
%% simulated experiment abundance maps
load 'abf';%load mixed;
abf = abf'; abf=reshape(abf,48,48,4);
for i=1:4
       figure()
       imagesc(abf(:,:,i)); % cbfreeze(colorbar);freezeColors;
end

%% parameter analysis
addpath './result'
% load result_RSNMF
load result_SID
lambda = [5e-4,1e-3,5e-3,1e-2,5e-2,1e-1,2e-1,3e-1];tau = [1e-4,1e-3,1e-2,1e-1];
xval = [1,2,3,4,5,6,7,8]; yval=[1,2,3,4];
SAD2 = reshape(result(2,:,2,:),8,4);RMSE2 = reshape(result(1,:,2,:),8,4); rel2 = reshape(result(3,:,2,:),8,4);

figure(11)
mesh([1,2,3,4,5,6,7,8],[1,2,3,4],SAD2');
xlabel('\lambda values', 'FontName', 'Times New Roman','FontSize',18,'rotation',15);
ylabel('\tau values', 'FontName', 'Times New Roman','FontSize',18,'rotation',-25);
zlabel('SAD', 'FontName', 'Times New Roman','FontSize',18);
axis([1 8 1 4 0 0.1]);
set(gca,'ztick',[0,0.02,0.04,0.06,0.08,0.10],'yticklabel',[0,0.02,0.04,0.06,0.08,0.10]);
set(gca,'xtick',[1,3,5,7,8],'xticklabel',[5e-4,5e-3,5e-2,2e-1,3e-1]);
set(gca,'ytick',[1,2,3,4],'yticklabel',[1e-4,1e-3,1e-2,1e-1]);
set(gca,'position',[0.12 0.12 0.80 0.80])

figure(22)
mesh([1,2,3,4,5,6,7,8],[1,2,3,4],RMSE2');
xlabel('\lambda values', 'FontName', 'Times New Roman','FontSize',18,'rotation',15);
ylabel('\tau values', 'FontName', 'Times New Roman','FontSize',18,'rotation',-25);
zlabel('RMSE', 'FontName', 'Times New Roman','FontSize',18);
axis([1 8 1 4 0 0.3]);
set(gca,'ztick',[0,0.05,0.10,0.15,0.20,0.25,0.30],'yticklabel',[0,0.05,0.10,0.15,0.20,0.25,0.30]);
set(gca,'xtick',[1,3,5,7,8],'xticklabel',[5e-4,5e-3,5e-2,2e-1,3e-1]);
set(gca,'ytick',[1,2,3,4],'yticklabel',[1e-4,1e-3,1e-2,1e-1]);

figure(33)
mesh([1,2,3,4,5,6,7,8],[1,2,3,4],rel2');
xlabel('\lambda values', 'FontName', 'Times New Roman','FontSize',18,'rotation',15);
ylabel('\tau values', 'FontName', 'Times New Roman','FontSize',18,'rotation',-25);
zlabel('relerr', 'FontName', 'Times New Roman','FontSize',18);
axis([1 8 1 4 0 0.03]);
set(gca,'ztick',[0,0.01,0.02,0.03],'yticklabel',[0,0.01,0.02,0.03]);
set(gca,'xtick',[1,3,5,7,8],'xticklabel',[5e-4,5e-3,5e-2,2e-1,3e-1]);
set(gca,'ytick',[1,2,3,4],'yticklabel',[1e-4,1e-3,1e-2,1e-1]);

%% bar with different initilization
y_sad  = [0.22188  0.0230 0.02168;0.25488 0.0288 0.02148];
y_rmse = [0.0679 0.0243 0.01648;0.08986 0.0328 0.03082];
figure();bar(y_sad)
figure();bar(y_rmse)

%% mu analysis with lambda = 0.005 and tao = 1e-2;
RMSE = [0.0247, 0.0247,0.0246, 0.0246 ];
SAD  = [0.0238, 0.0239, 0.0239, 0.0240];
x = [1 2 3 4];
plot(x,SAD,'b','LineWidth',2,'MarkerFaceColor','g','MarkerSize',10);
% plot(x,SAD,'b','LineWidth',3);
hold on;
plot(x,RMSE,'r--','LineWidth',3)
xlabel('parameter \mu', 'FontName', 'Times New Roman','FontSize',18);
ylabel('SAD&RMSE', 'FontName', 'Times New Roman','FontSize',18);
set(gca, 'FontName', 'Times New Roman','FontSize',18);
% set(gcf,'Position',[300 300 300 200]);
axis([1 4 0.02 0.03])
set(gca,'ytick',[0.02 0.025 0.03],'yticklabel',[0.02 0.025 0.03]);
set(gca,'xtick',[1 2 3 4],'xticklabel',[1e1 1e2 1e3 1e4]);
box on
% set(gcf,'Position',[200 200 520 440]);
legend('SAD','RMSE','location','northwest')

