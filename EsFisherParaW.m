function [jg_dd_dip,es_k,flag]=EsFisherParaW(j_dd_dip,w)
%jg_dd_dip-2 x 1 matrix ���������[����;���] ����
%j_dd_dip-2 x n matrix �������[����;���] ����
%es_k- ���Ƶ�kֵ
%w-��Ȩ��
[row,col]=size(j_dd_dip);
l=0;m=0;n=0;
for j=1:col
	alpha=j_dd_dip(1,j); beta=j_dd_dip(2,j);
	%���������꣬theta��phi
	theta=beta;
	if alpha<=0.5*pi
		phi=0.5*pi-alpha;
	else
		phi=2.5*pi-alpha;	
	end
	l=l+w(j)*sin(theta)*cos(phi);
	m=m+w(j)*sin(theta)*sin(phi);
	n=n+w(j)*cos(theta);
end
%�ϳɾ���
r=(l^2+m^2+n^2)^0.5;
%ƽ������mu��ƽ��������z��ļнǣ�nu�Ƿ�λ��
mu=acos(n/r); cos_phi=l/(r*sin(mu)); sin_phi=m/(r*sin(mu));
%cos_phi=-0.7071;sin_phi=-0.7071;
%���������жϣ�����nu
if sin_phi>=0
	if cos_phi>=0
		nu=asin(sin_phi);	
	else
		nu=acos(cos_phi);
	end
else
	if cos_phi<=0
		nu=pi+asin(-sin_phi);	
	else
		nu=2*pi+asin(sin_phi);
	end
end
%mu=mu*180/pi; nu=nu*180/pi
%ת���ɵ�������Ҫ���������,������joint group

if nu>0.5*pi
	m_dd=2.5*pi-nu;
else
	m_dd=0.5*pi-nu;
end
m_dip=mu;	
%����������Ĳ�״
jg_dd_dip=[m_dd;m_dip];
%[row,col]=size(j_dd_dip);
%es_k=(col-1)/(col-r*col/sum(w));
%return

%%%%%���±���

%ת������nto
nto=[cos(mu)*cos(nu),cos(mu)*sin(nu),-sin(mu);-sin(nu),cos(nu),0;sin(mu)*cos(nu),sin(mu)*sin(nu),cos(mu);];
nto=PruneMartix(nto,1e-5);

c=zeros(1,col);
for j=1:col
	alpha=j_dd_dip(1,j); beta=j_dd_dip(2,j);
	%���������꣬theta��phi�����ഺ���ڵ���
	theta=beta;
	if alpha<=0.5*pi
		phi=0.5*pi-alpha;
	else
		phi=2.5*pi-alpha;	
	end
	nv=nto*[(sin(theta)*cos(phi));(sin(theta)*sin(phi));cos(theta)];
	c(j)=1-nv(3,1);
end
%��ɢ�����Ĺ���
es_k0=col/sum(c);
es_k1=(col-1.0)*es_k0/col;
es_k2=(col-2.0)*es_k0/col;
es_k3=(1.0-1.0/col)^1.5*es_k0;
%ͳ�Ƽ����Ǳ�Ҫ�Ŀ�������
%����3��k�Ĺ���ֵ������ͳ�Ƽ���˵����~~~
%����
%�趨nk�ݣ�5���ǽ��ٵ�
nk=5; 
ndiv=(max(c)-min(c))/nk;
edge=zeros(1,(nk+2));
edge(1,1)=min(c);
for j=2:(nk+2)
	edge(1,j)=edge(1,1)+(j-1)*ndiv;
end
[nc,bin] = histc(c,edge); 

ts_k=[es_k1,es_k2,es_k3];
%��¼chiֵ�ľ���
tp_k=zeros(1,3);
%������ۼ������ k*exp(-c*k);
p=zeros(1,(nk+1));
for i=1:3
	es_k=ts_k(1,i);
	for j=2:(nk+2)
		p(j-1)=-[exp(-es_k*edge(j))-exp(-es_k*edge(j-1))];
	end
	%���㿨��chi
	chi=0;
	for j=1:(nk+1)
		chi=chi+(nc(j)-col*p(j))^2/(col*p(j));
	end
	tp_k(1,i)=chi;
end
%�ҳ���С��chiֵ
[chi,ind]=min(tp_k);
es_k=ts_k(1,ind);

%������ˮƽalpha=0.05��chi2(1-alpha)=
if chi<chi2inv(0.95,(nk-2))
flag=1;
else
flag=0;
end