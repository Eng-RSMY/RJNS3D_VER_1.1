clear all; close all;
x0=0;y0=0;z0=0;%ԭ��
dx=10;dy=10;dz=10;%�����
%lumta--density
lumtav=0.05;%����ܶ�

t=[135;45];%ƽ����״
jg_dd_dip=t*pi/180;
es_k=100;%Fisher����
B1=1;%��������Сֵ
B2=10;%���������ֵ
lamda=5;%ָ���ֲ�����

point_c=PoissonProcess3D2(lumtav,dx,dy,dz);
[row,num_joint]=size(point_c);

% j_dd_dip=GenFisherRand(jg_dd_dip,es_k,num_joint);

j_dd_dip(1,1:num_joint)=165*pi/180*ones(1,num_joint);
j_dd_dip(2,1:num_joint)=45*pi/180*ones(1,num_joint);

% radius=unifrnd(B1,B2,num_joint);
% radius = exprnd(lamda,1,num_joint);  %��������ǳ�����---ָ���ֲ�
radius=ones(1,num_joint);

[r_v_m,hcuoid]=GenCuboid(x0,y0,z0,dx,dy,dz);
DisAxis([0;0;0;],3); % the global coordinate red--z; blue--y; green--x;
view(3);  axis equal
patch_handle=zeros(1,num_joint);
% the determined parameters of elliptical joints
for i=1:num_joint
patch_handle(1,i)=GenDiskJoint(point_c(:,i),j_dd_dip(:,i),radius(i),r_v_m);
end
set(gca,'FontSize',15)
print -depsc 'REV.eps'



% set(gcf,'Units','inches');
% screenposition = get(gcf,'Position');
% set(gcf,...
%     'PaperPosition',[0 0 screenposition(3:4)],...
%     'PaperSize',[screenposition(3:4)]);    
% print(gcf,'-dpdf','REV.pdf')


% 
% % rmc=[0.5*dx;0.5*dy;0.5*dz];% the center coordinates of measuring widow
% % mw_dd_dip=[3.0*pi/2.0;1*pi/2.0]; % the orientation of measuring widow
% % mwh=16;  mwv=8; % the vertical and horizontal length of measuring widow
% % [beta_loc,theta,len_c_tra,len_d_tra,len_t_tra,plane_p,hmw3]=GenRMWA2(x0,y0,z0,dx,dy,dz,point_c,j_dd_dip,patch_handle,rmc,mwh,mwv,mw_dd_dip);
% % 
% % 
% % %�趨����߶�����
% % ms=[3 2.5 2 1.5 1];%����߶�����
% % [rec_cv,rec_cc]=CalFractalDim2D(mwh,mwv,ms,plane_p);
% % %���txt�ļ�
% % rec_cv%�����߶��¸�����϶�ķ�����Ŀ������Ϊ����ά���Ƿ�������
% 
% 
% %ȡо���������������ά
% mwh=5;%ȡо��/��
% mwv=5;%ȡо�߶�
% [r_v_m,hcuoid]=GenCuboid((0.5*(dx-2*mwh)),(0.5*(dy-2*mwv)),(0.5*(dy-2*mwv)),(2*mwh),(2*mwh),(2*mwh));
% view(3);  axis equal
% cpoint_c=[];cj_dd_dip=[];cradius=[];cpatch_handle=[];
% for i=1:num_joint
%     h=GenDiskJoint(point_c(:,i),j_dd_dip(:,i),radius(i),r_v_m);%��¼��ȡо�����ཻ��Բ�̸���
%     if h~=-1
%         cpatch_handle=[cpatch_handle,h];
%         cpoint_c=[cpoint_c,point_c(:,i)];
%         cj_dd_dip=[cj_dd_dip,j_dd_dip(:,i)];
%         cradius=[cradius,radius(i)];
%     end
% end
% ms=[2.5 2 1.5 1 0.5];%����߶�����
% sx0=(0.5*(dx-2*mwh));  sy0=(0.5*(dy-2*mwv)); sz0=(0.5*(dy-2*mwv));
% rec_cv=CalFractalDim3D(sx0,sy0,sz0,mwh,mwv,ms,cpatch_handle,cpoint_c,cj_dd_dip,cradius);
% %���txt�ļ�
% rec_cv%�����߶��¸�����϶�ķ�����Ŀ������Ϊ����ά���Ƿ�������
