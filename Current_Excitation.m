function [Amp]=Current_Excitation(M,N,dx,dy)%��������ֲ�Amn

midM=(M-1)/2;midN=(N-1)/2;
Xm=[];Yn=[];%��(m, n)�����е�Ԫ�����ĵ������
for m=1:1:M
    Xm(m)=(m-midM-1)*dx;
end
% ������yn(n)����������y������꣬��֤��˼·�ǵ�16������Ϊ0
for n=1:1:N
    Yn(n)=(n-midN-1)*dy;
end
ampx=ones(1,M);%��x����Ϊ�ȷ���
ampy=ones(1,N);
for i=1:N
    ampy(i)=cos(pi*(i-midN-1)/N);%y�������ҷֲ�
end
SLL=-20;
R0=10^(SLL/(-20));
a0=cosh(acosh(R0)/(M-1));  
 
Ix=[];
for j=1:1:midM
    
    Ix(1)=(-1)^(midM-j-1)*a0^(2*(j-1))*(factorial(1+midM-2)*(2*midM)...
        /(2*factorial(j-1)*factorial(j+1-2)*factorial(midM-j+1)));

end

for i=2:midM
    for j=1:1:midM
        
        Ix(i)=(-1)^(midM-j-1)*a0^(2*(j-1))*(factorial(i+midM-2)*(2*midM)...
        /(1*factorial(j-i)*factorial(j+i-2)*factorial(midM-j+1)));
        
    end
end


Amp=ampx'*ampy;
[ymesh,xmesh]=meshgrid(Yn,Xm);
figure(1);
surf(xmesh,ymesh,Amp);
xlabel('xdimension');ylabel('ydimension');title('�Գ����ӷ��ȷֲ�');
disp('__________Complete the calculation of current__________');
end