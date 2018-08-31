clear all; close all;
x0=0;y0=0;z0=0;
dx=20;dy=40;dz=20;
%lumta--density
lumtav=0.005;
beta=pi/2;
k_axis=2;
jg_dd_dip=[135;45]*pi/180;
es_k=9;%Fisher

point_c=PoissonProcess3D2(lumtav,dx,dy,dz);
[row,num_joint]=size(point_c);

%%
%Fisher
j_dd_dip=GenFisherRand(jg_dd_dip,es_k,num_joint);
%j_dd_dip=[jg_dd_dip(1,1)*ones(1,num_joint);jg_dd_dip(2,1)*ones(1,num_joint)];

%%


B1=2;%
B2=12;%
major_axis=unifrnd(B1,B2,1,num_joint);   %����---���ȷֲ�

% lamda=5;%ָ���ֲ�--��ֵ
% major_axis = exprnd(lamda,1,num_joint);  %����---ָ���ֲ�
% 
% MU=15;%������̫�ֲ�--��ֵ
% SIGMA=1;%������̫�ֲ�--��׼��
% major_axis = normrnd(MU,SIGMA,1,num_joint); %����---��̫�ֲ�
% 
% MU=3;%������̫�ֲ�--��ֵ
% SIGMA=0.1;%������̫�ֲ�--��׼��
% major_axis = lognrnd(MU,SIGMA,1,num_joint); %����---������̫�ֲ�


% a_min=1.117;%������Сֵ
% a_max=10;%�������ֵ
% major_axis=JointSizeRand_TraUni(a_max,a_min,num_joint);  %����--����Ϊ���ȷֲ�

% a_min=1;%������Сֵ
% a_max=50;%�������ֵ
% D=1.5;%������ά
% major_axis=JointSizeRand_TraFractal(D,a_min,a_max,num_joint);  %����--����Ϊ���ηֲ�

% load Size_PDF
% major_axis=JointSizeRand(g,a_max,a_min,num_joint);  %����--����Ϊ����ʽ�ֲ�


%%

[r_v_m,hcuoid]=GenCuboid(x0,y0,z0,dx,dy,dz);
DisAxis([0;0;0;],3); % the global coordinate red--z; blue--y; green--x;
view(3);  axis equal
patch_handle=zeros(1,num_joint+1);
% the determined parameters of elliptical joints
for i=1:num_joint
patch_handle(1,i)=GenEllipiseJoint(point_c(:,i),j_dd_dip(:,i),major_axis(i),k_axis,beta,r_v_m);
end

break


%%%%%%%%%%���ӵ�����϶%%%%%%%%%%%%%%%%%%%%
num_joint=num_joint+1;
j_dd_dip(:,num_joint)=[135;45]*pi/180;%��϶��״
point_c(:,num_joint)=[10;20;10];%���ĵ�����
major_axis(:,num_joint)=50;%�����С
patch_handle(1,i+1)=GenEllipiseJoint(point_c(:,num_joint),j_dd_dip(:,num_joint),major_axis(:,num_joint),k_axis,beta,r_v_m);
% ���������ÿһ���������excel�ļ�
% point_c %3 x n matrix������Ϊ����϶���ĵ����ꡱ
% j_dd_dip %2 x n matrix������Ϊ����϶��״��
% major_axis %1x n matrix������Ϊ����϶����ߴ硱
%  xlswrite('C:\Users\Administrator\Desktop\����\��϶���ĵ�����.xls',point_c);
%  xlswrite('C:\Users\Administrator\Desktop\����\��϶��״.xls',j_dd_dip);
%  xlswrite('C:\Users\Administrator\Desktop\����\��϶����ߴ�.xls',major_axis);


% %
% %%%%%%%%%%%%%%���ε��ⴰ%%%%%%%%%%%%%%%%%%%%%
% rmc=[0.5*dx;0.5*dy;0.5*dz];% the center coordinates of measuring widow
% mw_dd_dip=[3.0*pi/2.0;1*pi/2.0]; % the orientation of measuring widow
% mwh=16;  mwv=8; % the vertical and horizontal length of measuring widow
% [beta_loc,theta,len_c_tra,len_d_tra,len_t_tra,plane_p,hmw3]=GenRMWA2(x0,y0,z0,dx,dy,dz,point_c,j_dd_dip,patch_handle,rmc,mwh,mwv,mw_dd_dip);
% �ⴰ�и�����������ÿһ���������txt�ļ�
% plane_p %6 x n matrix���ڲⴰƽ��ֲ�����ϵ�µļ������˵����꣬����Ϊ�����߶˵����ꡱ
% len_c_tra %����Ϊ��δɾ�ڼ�����
% len_d_tra %����Ϊ��һ��ɾ�ڼ�����
% len_t_tra %����Ϊ������ɾ�ڼ�����


% %%%%%%%%%%%%%�ⷽ��Բ˫�ⴰ%%%%%%%%%%%%%%%%%%%%
% cmwa=[0.5*dx;0.5*dy;0.5*dz]; %�ⴰ���ĵ�����
% mw_dd_dip=[pi/2.0;pi/2.0];   %�ⴰ���������
% ratio_h=1.5; %ratio_h--��ⴰˮƽ��/�ڲⴰ�뾶֮��
% ratio_v=2;   %ratio_v--��ⴰ��ֱ��/�ڲⴰ�뾶֮��
% cmra=5;      %�ⴰԲ�ΰ뾶
% [hmw2,hmw3,len_tc_tra,len_td_tra,len_tcd_tra,len_tct_tra]=GenMutiCMWA2(x0,y0,z0,dx,dy,dz,point_c,j_dd_dip,patch_handle,cmwa,cmra,mw_dd_dip,ratio_h,ratio_v);
% %�ⴰ�и�����������ÿһ���������txt�ļ�
% len_tc_tra %����Ϊ���ڲⴰδɾ�ڼ�����
% len_td_tra %����Ϊ���ڲⴰһ��ɾ�ڼ���-�������ⴰ�ⳤ�ȡ�
% len_tcd_tra %����Ϊ���ڲⴰһ��ɾ�ڼ���-�����ⴰ�ⳤ�ȡ�
% len_tct_tra %����Ϊ���ڲⴰ����ɾ�ڼ�����


% %%%%%%%%%%%%%%�ⷽ�ڷ�˫�ⴰ%%%%%%%%%%%%%%%%%%%%
% rmwa=[0.5*dx;0.5*dy;0.5*dz];  %�ⴰ���ĵ�����
% mw_dd_dip=[0*pi/2.0;pi/2.0];    %�ⴰ���������
% ratio_h=2.3; %ratio_h--��ⴰ/�ڲⴰˮƽ��֮��
% ratio_v=2;   %ratio_v--��ⴰ/�ڲⴰ��ֱ��֮��
% mwh=8;%�ڲⴰˮƽ��
% mwv=6;%�ڲⴰ��ֱ��
% [len_tc_tra,len_td_tra,len_tcd_tra,len_tct_tra]=GenMutiRMWA2(x0,y0,z0,dx,dy,dz,point_c,j_dd_dip,patch_handle,rmwa,mwh,mwv,mw_dd_dip,ratio_h,ratio_v);
% % %�ⴰ�и�����������ÿһ���������txt�ļ�
% % len_tc_tra %����Ϊ���ڲⴰδɾ�ڼ�����
% % len_td_tra %����Ϊ���ڲⴰһ��ɾ�ڼ���-�������ⴰ�ⳤ�ȡ�
% % len_tcd_tra %����Ϊ���ڲⴰһ��ɾ�ڼ���-�����ⴰ�ⳤ�ȡ�
% % len_tct_tra %����Ϊ���ڲⴰ����ɾ�ڼ�����

%%
% % %%%%%%%%%%%%%%%�ⴰ���߷�ά���Ǽ���%%%%%%%%%%%%%%%%%%%%%
% %�趨����߶�����
% ms=[4 2 1 0.5 0.25];%����߶�����
% [rec_cv,rec_cc]=CalFractalDim2D(mwh,mwv,ms,plane_p);
% %���txt�ļ�
% rec_cv %�����߶��¸�����϶�ķ�����Ŀ������Ϊ�����Ƿ�������
% 
% %ȡо���������������ά
% mwh=8;%ȡо��/��
% mwv=8;%ȡо�߶�
% [r_v_m,hcuoid]=GenCuboid((0.5*(dx-2*mwh)),(0.5*(dy-2*mwv)),(0.5*(dy-2*mwv)),(2*mwh),(2*mwh),(2*mwh));
% view(3);  axis equal
% cpoint_c=[];cj_dd_dip=[];cradius=[];cpatch_handle=[];
% for i=1:num_joint
%     h=GenEllipiseJoint(point_c(:,i),j_dd_dip(:,i),major_axis(i),k_axis,beta,r_v_m);%��¼��ȡо�����ཻ��Բ�̸���
%     if h~=-1
%         cpatch_handle=[cpatch_handle,h];
%         cpoint_c=[cpoint_c,point_c(:,i)];
%         cj_dd_dip=[cj_dd_dip,j_dd_dip(:,i)];
%         cradius=[cradius,major_axis(i)];
%     end
% end
% ms=[2.5 2 1.5 1 0.5];%����߶�����
% sx0=(0.5*(dx-2*mwh));  sy0=(0.5*(dy-2*mwv)); sz0=(0.5*(dy-2*mwv));
% rec_cv=CalFractalDim3D(sx0,sy0,sz0,mwh,mwv,ms,cpatch_handle,cpoint_c,cj_dd_dip,cradius);
% %���txt�ļ�
% rec_cv%�����߶��¸�����϶�ķ�����Ŀ������Ϊ����ά���Ƿ�������
% 



%%%%%%%%%%%%%%%���ɶ��ƽ�����%%%%%%%%%%%%%%%%%%%%%
% num_borehole=5;%��׵ĸ������̶�ֵ
% m=20;%m-Բ�ܷ���ĵȷ������̶�ֵ
% 
% location=[10,5,10,15,10;
%           10,15,20,25,30;
%           0,0,0,0,0;];    % ��׵ײ��ռ����꣬��Ҫȫ������
%       
% bore_dip_direction=1*pi/4;  % ���������Ҫ����
% bore_dip_angle=0;           % �����ǣ���Ҫ����
% bore_dip=[bore_dip_direction*ones(1,num_borehole);bore_dip_angle*ones(1,num_borehole);];
% H=[20 20 20 20 20];%������׵���ȣ���Ҫȫ������
% radius=[1 1 1 1 1];%������׵İ뾶����Ҫȫ������
% for j=1:num_borehole
%     Genborehole(location(:,j),bore_dip(:,j),H(:,j),radius(:,j),m);
% end
% 
% flag_int=zeros(num_joint,num_borehole);
% flag_full=zeros(num_joint,num_borehole);
% for i=1:num_joint
%     for j=1:num_borehole
%         [flag_int(i,j),flag_full(i,j)]=IsborejointInsect(point_c(:,i),j_dd_dip(:,i),major_axis(i),k_axis,beta,location(:,j),bore_dip(:,j),radius(:,j));
%     end
% end
% N_intersect=sum(flag_int);
% N_fullintsect=sum(flag_full);
% mean_size=zeros(num_borehole,1);
% sigma=zeros(num_borehole,1);
% for i=1:num_borehole
%     [mean_size(i,1),sigma(i,1)]=CalmeanvarSize(lumtav,j_dd_dip(:,1),k_axis,beta,bore_dip(:,i),radius(:,i),H(:,i),N_intersect(1,i),N_fullintsect(1,i));
% end
% sigma=mean(sigma);
% mean_size=mean(mean_size);
%%���txt�ļ�
%N_intersect %����Ϊ����϶�����׽���������
%N_fullintsect %����Ϊ����϶��������ȫ����������
%mean_size %����Ϊ���ƶ���϶�ߴ��ֵ��
%sigma  %����Ϊ���ƶ���϶�ߴ��׼�


