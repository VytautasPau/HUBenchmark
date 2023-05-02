clear all

data_type = 1; %data_type  1   真实影像数据
%data_type  2   模拟影像数据

%%
if  data_type ==1
    %///////////////%真实影像实验/////////////////////////////////////////////////
%     infilename = 'E:\程序代码\数据\华盛顿数据\华盛顿去除噪音波段';
    infilename = 'E:\程序代码\数据\Cuprite数据\cuprite';
%     outfilename = 'a';
    %读入输入文件数据到image  (cols*lines)*bands中
    image = freadenvi(infilename);
    cols = 190;
    lines = 250;
    R = image';%原始数据R为band *n
    R=R/10000;
    [bands,N] = size(R);
    
%     load('C:\Users\DIY\Desktop\华盛顿参考.mat')
%     load('E:\程序代码\数据\华盛顿数据\华盛顿参考光谱.mat')
%     M = spectral;
    %1.初始化M，S
    %参数
    P = 12; %成分个数
    
%    load SID_initial华盛顿2.mat;
%    load('C:\Users\DIY\Desktop\华盛顿初始化.mat')
%     M_Ini = abs(initial(R,bands,P));
%     M_Ini = hyperVca(R,P);
load('C:\Users\DIY\Desktop\A_Ini cup.mat')
    M_Ini = A_Ini;
    S_Ini = hyperFcls(R,M_Ini);
%     S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *R;
    S_Ini = max(S_Ini,0.001);%去除负值
    S_Ini = min(S_Ini,1);%去除大于1的值
%     ini_thre = 0.001; %初始化M时,度量SID的阈值
%     load SID_initial华盛顿2.mat;
    %M_Ini = SID_Intial(R,ini_thre,P);
    %M_Ini= initial(R,bands,P,N);
    %M_Ini=M_Ini/10000;
    
%     S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *R;
%     S_Ini = max(S_Ini,0.001);%去除负值
%     S_Ini = min(S_Ini,1);%去除大于1的值
    
    %2.ASC
    thre = 10;
    [RA,MA] = ASC(R,M_Ini,thre);
    
    %3.进行各种约束，ASSNMF主体迭代
    %参数
    threshold = 0.01; %总体阈值
    thresholdAbund = 0.01; %丰度约束条件的阈值
    Time = 20 ;%运行最大时间
    maxiter = 400; %总体最大迭代次数
    row=lines;
    col=cols;
    u1= 0.28*N+1000;
    %  u2 =0 %5/P;
    u2 =5/P;
    [M_E,S_E,obj] = ASSNMF(R,M_Ini,S_Ini,RA,MA,threshold,thresholdAbund,maxiter,row,col,u1,u2);%估计端元和丰度
    
    %4. 输出
%     %丰度影像输出
%     enviwrite(S_E([1:P],:)',cols,lines,P,outfilename);
%     %估计光谱显示
%     figure
%     for i=1:P
%         subplot(3,4,i);plot(1:bands,M_E(1:bands,i),'g-')
%     end
    figure
    for i=1:P
        subplot(3,4,i);
        TT = reshape(S_E(i,:),190,250);
        TT = TT';
        imshow(TT,[]);
    end
% pipei = SAMpipei(spectral,M_E);
% disp(pipei);
end
% plot(M_E(1:187,6),'-b','LineWidth',2,'DisplayName','M_E(1:187,1)','YDataSource','M_E(1:187,1)');
% figure(gcf)
% hold on;
% plot(spectral(1:187,4),':r','LineWidth',2,'DisplayName','spectral(1:187,3)','YDataSource','spectral(1:187,3)');
% xlabel('band');ylabel('reflectance');
% title('Comparison');legend('Resulting Spectral','Reference Spectral');
% figure(gcf)



%%



if data_type ==2
    %////////////////////////模拟数据实验////////////////////////////
    load('E:\程序代码\My idea\数据\7端元SNR20纯度0.8端元数变化\X10.mat')
    load('E:\程序代码\My idea\数据\7端元SNR20纯度0.8端元数变化\Abundance10.mat')
    load('E:\程序代码\My idea\数据\7端元SNR20纯度0.8端元数变化\Reference10.mat')
%     load('E:\程序代码\ASSNMF\syndata_ASSNMF_25dB_pure 1.mat')
    P=10;
    row = 56; %一景影像行数
    col = 56; %一景影像列数
    %读入输入文件数据
    M = Reference;%真实端元
    S = Abundance;%真实丰度
    [bands,N] = size(X);
    
    
    disp([('初始化M,S ...')]);
    %1.初始化M，S
    
%     ini_thre = 0.3; %初始化M时,度量SID的阈值
%     %M_Ini = SID_Intial(R,ini_thre,P);
%     %load SID_initial_0.0914.mat;
%     M_Ini= hyperAtgp( X, P );
%     S_Ini = hyperFcls(X,M_Ini);

    M_Ini = abs(initial(X,bands,P));
    S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *X;
    S_Ini = max(S_Ini,0.001);%去除负值
    S_Ini = min(S_Ini,1);%去除大于1的值   

    % M_Ini = SID_Intial(R,ini_thre,component);
    %
    % S_Ini = inv(M_Ini'*M_Ini)* M_Ini' *R;
    % S_Ini = max(S_Ini,0.001);%去除负值
    % S_Ini = min(S_Ini,1);%去除大于1的值
    %
    disp([('ASC限制 ...')]);
    %2.ASC
%     thre = 0.02*bands;
    thre = 15;
    [XA,MA] = ASC(X,M_Ini,thre);
    
    disp([('进入ASSNMF迭代 ...')]);
    %3.进行各种约束，ASSNMF主体迭代
    %参数
    threshold = 0.02; %总体阈值
    thresholdAbund = 3e-5; %丰度约束条件的阈值
    %  Time = 20 ;%运行最大时间
    maxiter = 500; %总体最大迭代次数
    
    u1 = 0.28*N;
   
    %  u2 =0 %5/P;
    u2 =5/P;
    tic
    [M_E,S_E,obj,consobj] = ASSNMF(X,M_Ini,S_Ini,XA,MA,threshold,thresholdAbund,maxiter,row,col,u1,u2);%估计端元和丰度
    toc
   
    pipei = SAMpipei(Reference,M_E);
    rmse = RMSE(Abundance,S_E,pipei(1,:),pipei(2,:));
    disp(pipei);
    disp(rmse);
%     disp([('输出显示 ...')]);
    %4. 输出
%     figure
%     for i=1:P
%         subplot(4,P,i);plot(1:bands,M_E(1:bands,i),'g-')
%         subplot(4,P,i+P);plot(1:bands,M(1:bands,i),'b-')
%     end
%     figure;
%     for i=1:P
%         subplot(3,4,i);
%         TT = reshape(S_E(i,:),col,row);
%         TT = TT';
%         imshow(TT,[]);
%     end
end

% plot(M_E(1:391,5),'-b','LineWidth',2,'DisplayName','M_E(1:391,1)','YDataSource','M_E(1:391,1)');
% figure(gcf)
% hold on;
% plot(Spectral(1:391,3),':r','LineWidth',2,'DisplayName','Spectral(1:391,3)','YDataSource','Spectral(1:391,4)');
% xlabel('band');ylabel('reflectance');
% title('Comparison');legend('Resulting Spectral','Reference Spectral');
% figure(gcf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%结果评估
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [band,P1] = size(M_E);
% [P1,N]=size(S_E);
% [band,P2] = size(M);
% 
% sam = SAMpipei(M,M_E)
% sid = SIDpipei(M,M_E)
% rmse = RMSE(S,S_E,sam(1,:),sam(2,:))




