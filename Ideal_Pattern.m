function Ideal_Pattern(Amp,M,N,lambda,dx,dy,Im,theta)%计算理想平面方向图
% Input Parameter:
% Amp:[43*31]电流幅度分布矩阵
% M:x方向对称阵子个数
% N:y方向对称阵子个数
% lambda:为波长
% dx:为x方向采样点间距
% dy:为y方向采样点间距
% Im:半波阵子波腹电流
% theta:与z轴的夹角
midM=(M-1)/2;midN=(N-1)/2;
k=2*pi/lambda;%波长
%% E面方向图
fEtheta=0;
for m=1:1:M
    for n=1:1:N
        fEtheta=fEtheta+Amp(m,n)*exp(1i*k*(m-midM-1)*dx.*sin(theta));
    end
    
end
fEtheta=60*Im*abs(cos(0.5*pi*sin(theta))./cos(theta)).*abs(fEtheta);
figure(2);
plot(180*theta/pi,20*log(fEtheta./max(fEtheta)));%直角坐标绘图且归一化处理
hold on;
title('归一化E面理论方向图');xlabel('theta');ylabel('f_Etheta');

figure(3);
% polarplot(theta,20*log(max(fEtheta)./fEtheta));%极坐标归一化处理
polarplot(theta,20*log(fEtheta));
pax=gca;
pax.ThetaDir='clockwise';
pax.ThetaZeroLocation='top';
title('E面方向图理论结果');


%% H面方向图
fHtheta=0;
for m=1:M
    for n=1:N
        fHtheta=fHtheta+Amp(m,n)*exp(1i*k*(n-midN-1)*dy.*sin(theta));
    end
end
fHtheta=60*Im*abs(fHtheta);
figure(4);
plot(180*theta/pi,20*log(fHtheta./max(fHtheta)));%直角坐标绘图且归一化处理
hold on;
title('归一化H面理论方向图');xlabel('theta');ylabel('f_Htheta');

figure(5);
% polarplot(theta,20*log(max(fEtheta)./fEtheta));%极坐标归一化处理
polarplot(theta,20*log(fHtheta));

pax=gca;
pax.ThetaDir='clockwise';
pax.ThetaZeroLocation='top';
title('H面方向图理论结果');

disp('__________Complete the calculation of ideal pattern__________');
end
