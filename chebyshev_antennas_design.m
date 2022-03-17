function I = chebyshev_antennas_design(N, dlamr, str, value)
% CHEBYSHEV_ANTENNAS_DESIGN �б�ѩ�����ߵ������
%   I = CHEBYSHEV_ANTENNAS_DESIGN(N, dlamr, str, value)
%       N       ���ߵ�Ԫ����
%       dlamr   ���ߵ�Ԫ����벨��֮�� (distance and lambda ratio)
%       str     ָ����֪������ֻ��Ϊ SLL �� PNBW
%       value   str ��ֵ
%   ��� I      ��һ���ĵ���
%
%   ���磺
%         clear, clc;
%         N = 8;
%         dlamr = 0.5;
%         str = 'SLL';
%         value = -25;
%         I = chebyshev_antennas_current(N, dlamr, str, value)
%   ���Ϊ��
%         I =
%               0.37783485957707
%              0.584272242824945
%              0.842415295145896
%                              1
%                              1
%              0.842415295145896
%              0.584272242824945
%               0.37783485957707


    % ���ݲ�ͬ����������ʹ�ò�ͬ�ķ������ϵ�� a0
    % һ������԰��ƽ��SLL�������㹦�ʲ����ȣ�PNBW��
    if strcmp(str, 'SLL') || strcmp(str, 'sll')
        a0 = sll2a0(N, value);
    elseif strcmp(str, 'PNBW') || strcmp(str, 'pnbw')
        a0 = fnbw2a0(N, dlamr, value);
    else
        error('����ȷָ�� SLL �� PNBW��');
    end

    % ��� N-1 ���б�ѩ�����ʽ��ϵ��
    [p, T] = chebyshev(N-1,1);
    T = T(:, end:-2:1);     % ȡ����Ҫ�Ĳ���
    
    % �����ʽ�ұߣ�ʹ���������б�ѩ�����ʽ
    A0 = a0*ones(N,1);
    A0 = vander(A0);
    A0 = A0(1, :)';
    Tp = p .* A0;
    
    % ȥ��ȫ����
    index = Tp ~= 0;
    T = T(index, :);
    Tp = Tp(index, :);

    % �ж���ż��
    isNodd = mod(N,2);
    if isNodd
        T(end) = T(end)/2;
    end

    % ��ⷽ��ϵ����������ֵ
    I = T\Tp;
    
    % �õ�ÿ�����ߵ�Ԫ��ĵ�������
    I = I/max(I);
    if isNodd
        I = [I; flipud(I(1:end-1))];
    else
        I = [I; flipud(I)];
    end
    
    % ����ͼ
    theta = linspace(-pi, pi, 360);
    x = cos(2*pi*dlamr * sin(theta) /2);    
    fn = polyval(p, a0*x);
    f = abs(fn);
    f = f/max(f);
%     plot(theta/pi*180, f);       % ֱ������ϵ�ķ���ͼ
    figure;
    polar(theta,f);
    view(90, -90);
    title([num2str(N), ' Ԫ�б�ѩ�����ߵķ���ͼ']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% a0 �����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a0 = sll2a0(N,SLL)
    R0 = 10^(-SLL/20);
    
    Rt = sqrt(R0^2 - 1);
    a0 = 0.5 * ( power(R0 + Rt, 1/(N-1)) + power(R0 + Rt, -1/(N-1)) );
end
function a0 = fnbw2a0(N, dlamr, theta01)
    x01 = cos(pi*dlamr * sind(theta01/2));
    a0 = cos(pi/2/(N-1))./x01;
end
