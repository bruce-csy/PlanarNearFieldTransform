clc;
clear;
% ȷ���������������ĵ�
% MΪx�᷽��벨�Գ����Ӹ���
% NΪy�᷽��Գ����Ӹ���
M=43;
N=31;
% M1��N1�ֱ�ΪM��N����λ��
M1=(M-1)/2;
N1=(N-1)/2;
lambda=100;
% dx��dyΪ�Գ�������x����ļ�����y����ļ��
% d��d1��ȡ�������������ľ���
dx=0.7*lambda;
dy=dx;
d=4.5*lambda;
d1=6.5*lambda;
% deltax��deltayΪ��x���y���ϵĲ������
deltax=0.45*lambda;
deltay=0.45*lambda;
% Mc��Nc�ֱ�Ϊ��x��y����Ĳ�����
Mc=133;
Nc=95;
% Mc1��Nc2ΪMc��Nc����λ��
Mc1=(Mc-1)/2;
Nc1=(Nc-1)/2;
% ��(m,n)�����е�Ԫ�����ĵ�����Ϊ((m-M1-1)dx,(n-N1-1)dy)
% ��(m,n)�����е�Ԫ�������˵������Ϊ((m-M1-1)dx+lanbda/4��(m-M1-1)dx-lanbda/4,(n-N1-1)dy,0)
% ������Xm1�������Ϊ(m-M1-1)dx+lambda/4
% ��Xm11�������Ϊ(m-M1-1)dx-lambda/4
% ������y�������Ϊ(n-N1-1)dy��yn
% ��ȡ����x������Ϊ(l1-M2-1)*deltax��Xl1
% ��ȡ����y������Ϊ(l2-N2-1)*deltay��yl2
Xm1=[];
Xm11=[];
yn=[];
Xl1=[];
yl2=[];
% ������Xm1(m)�������ϱ۵����꣬��֤��˼·�ǵ�22�����ӵ��ϱ�����Ӧ����0.025
for m=1:1:M
    Xm1(m)=(m-M1-1)*dx+lambda/4;
end
% ������Xm11(m)�������±۵����꣬��֤��˼·�ǵ�22�����ӵ��±�����Ӧ����-0.025
for m=1:1:M
    Xm11(m)=(m-M1-1)*dx-lambda/4;
end
% ������yn(n)����������y������꣬��֤��˼·�ǵ�16������Ϊ0
for n=1:1:N
    yn(n)=(n-N1-1)*dy;
end
% ������l1Ϊ�������x�����꣬��֤��˼·�ǵ�67������x������Ϊ0
for l1=1:1:Mc
    Xl1(l1)=(l1-Mc1-1)*deltax;
end
% ������l2Ϊ�������y�����꣬��֤��˼·�ǵ�48��Ϊ0
for l2=1:1:Nc
    yl2(l2)=(l2-Nc1-1)*deltay;
end
% ����������R1mn,R2mn��Ex
% R1mn��R2mn�ֱ�Ϊ���������ϱۺ��±۵�ȡ����ľ���
% Ex��ʾȡ����x�������Ϊd�ĵ糡
% Ex1��ʾȡ����x�������Ϊd1�ĵ糡
% Ey��ʾȡ����y����ĵ糡
% addΪ���ӱ���
R1mn=[];
R2mn=[];
Ex=[];
Ey=[];
Ex1=[];
Rhon=[];
add=0;
add1=0;
for p=1:1:Mc
    for q=1:1:Nc
        for m=1:1:M
            for n=1:1:N
                R1mn(m,n)=sqrt((Xm1(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d^2);
                R2mn(m,n)=sqrt((Xm11(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d^2);
                R1mn1(m,n)=sqrt((Xm1(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d1^2);
                R2mn1(m,n)=sqrt((Xm11(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d1^2);
                Rhon(n)=sqrt((yl2(q)-yn(n))^2+d^2);
                add1=add1+((Xl1(p)-Xm1(m))/Rhon(n)*exp(-1i*2*pi/lambda*R1mn(m,n))+(Xl1(p)-Xm11(m))/Rhon(n)*exp(-1i*2*pi/lambda*R2mn(m,n))/R2mn(m,n))*(yl2(q)-yn(n))/Rhon(n);
                add=add+exp(-1i*2*pi/lambda*R1mn(m,n))/R1mn(m,n)+exp(-1i*2*pi/lambda*R2mn(m,n))/R2mn(m,n);
                add2=add+exp(-1i*2*pi/lambda*R1mn1(m,n))/R1mn1(m,n)+exp(-1i*2*pi/lambda*R2mn1(m,n))/R2mn1(m,n);
            end
        end
        Ex(p,q)=-1i*30*add;
        Ey(p,q)=1i*30*add1;
        Ex1(p,q)=-1i*20*add2;
        add1=0;
        add=0;
        add2=0;
    end
end
% Ex_amp��d����4.5������ʱ�糡�ķ���
% Ex_phase��d����4.5������ʱ�糡����λ
% Ex1_amp��d����6.5������ʱ�糡�ķ���
% Ex1_phase��d����6.5������ʱ�糡�ķ���
Ex_amp=20*log10(abs(Ex));
Ey_amp=20*log10(abs(Ey));
Ey_phase=angle(Ey)*180/pi;
Ex_phase=angle(Ex)*180/pi;
Ex1_amp=20*log10(abs(Ex1));
Ex1_phase=angle(Ex1)*180/pi;

%�ع�����
X=[-(Mc-1)/2*deltax:deltax:(Mc-1)/2*deltax]';
Y=[-(Nc-1)/2*deltay:deltay:(Nc-1)/2*deltay]';
X=repmat(X,Nc,1);
Y=repmat(Y,Mc,1);
Z=d*ones(Mc*Nc,1);
ExReal=reshape(Ex_amp,Mc*Nc,1);
ExImg=reshape(imag(Ex),Mc*Nc,1);
EyReal=zeros(Mc*Nc,1);
EyImg=zeros(Mc*Nc,1);
EzReal=zeros(Mc*Nc,1);
EzImg=zeros(Mc*Nc,1);
data_nf = table(X,Y,Z,ExReal,ExImg,EyReal,EyImg,EzReal,EzImg,ExReal,ExImg);
data_nf.Properties.VariableNames = {'X' 'Y' 'Z' 'ExReal' 'ExImg' 'EyReal' 'EyImg' 'EzReal' 'EzImg' 'EabsReal' 'EabsImg'};
data_nf=rearrangeTables(data_nf);
delta_theta=1;
delta_phi=1;
theta_range = linspace(-60,60,570)*pi/180;
phi_range= linspace(0,180,798)*pi/180;

% theta_range = linspace(-60,60,95);
% phi_range= linspace(0,180,133);

f=3*10^9;
fft_padding = 6;
%��Զ���任
data_nf2ff = nf2ff_planar_fft(data_nf,f,phi_range,theta_range,fft_padding,'none');
%��ͼ
disp('Plotting...')
close all
fontsize = 14;
normalized = true;
logarithmic = true;
% plotNFPhiCut(data_nf2ff,0,normalized,logarithmic);
plotNFPhiCut(data_nf2ff,0,normalized,logarithmic);
