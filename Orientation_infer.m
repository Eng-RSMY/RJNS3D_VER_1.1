clear all; close all; clc;
t=load('������϶�������.txt');  %j_dd_dip--2xn matrix, �����[����;���] �Ƕ�
t=t';
j_dd_dip=t*pi/180;
[jg_dd_dip,es_k]=EsFisherPara(j_dd_dip);
jg_dd_dip=jg_dd_dip*180/pi;
% %���������ÿһ���������txt�ļ�
jg_dd_dip %����Ϊ��ƽ����״��
es_k      %����Ϊ��Fisher ���Ʋ�����



rmc=[10;10;10];%�ⴰ�Ŀռ����꣬[x;y;z]
mwdy=5;%�ⴰ���
mwdx=5;%�ⴰ�볤
t=[135;90];%�ⴰ��״   [����;���] �Ƕ�
mw_dd_dip=t*pi/180;
m=10;%PossionԲ��ֱ����ֵ
w=CalWeightSamBias(j_dd_dip,rmc,mwdy,mwdx,mw_dd_dip,m);
[jg_dd_dip,es_k,flag]=EsFisherParaW(j_dd_dip,w);
jg_dd_dip=jg_dd_dip*180/pi;
% %���������ÿһ���������txt�ļ�
jg_dd_dip %����Ϊ��ƽ����״��
es_k      %����Ϊ��Fisher ���Ʋ�����




es_lumtaa=0.12;%��϶����ܶ�
es_lumtav=CalJointVolDens(jg_dd_dip,mw_dd_dip,es_lumtaa,m);
% %���������ÿһ���������txt�ļ�
es_lumtav%����ܶ�