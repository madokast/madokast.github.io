% code created by       �º���
% code re-factoring by  �ر�
% version 0.9, 2020-April-8

% TODO: ���б����ĳ�ʸ����

close all;clear;clc
t1=clock;

    global N;
    global I1;
    global I2;
    global I3;
    global I4;
    global step;
    global total_steps;
    global miu;
    global R;
    
    global ln1;
    global ln2;
    global wn1;
    global wn2;
    
    global MultiLines_1;
    global MultiLines_2;
    global MultiLines_3;
    global MultiLines_4;

%----------AG-CCT��Ʋ���----------

R=1.25;        % ����AG-CCT����ת�뾶
phi0=75*pi/180/347;   % AG-CCT��Ȧ����ת�Ǿ�
step=pi/180;    % ����
miu=4*pi*10^(-7);      % �ϰ��������ų�����miuֵ
N=347;        % ������Ȧ����

%-------�ڲ�AG-CCT��Ʋ���-------
r1=0.055;    % �ڲ�AG-CCT��Ȧ�뾶   
D=-0.0505;    % �ڲ�AG-CCT�����ų�����
alpha1=32.5*pi/180;   % �ڲ�AG-CCT��ǣ�Ҳ���ļ��ų�����
S=0.0975;    % �ڲ�AG-CCT�����ų�����
T=0.0025;     % �ڲ�AG-CCT�˼��ų�����
I1=7586.8;     % �ڲ�AG-CCT��Ȧ����ֵ
a1=sqrt(R*R-r1*r1);     % �ڲ�AG-CCT˫������ϵ�ļ���
eta01=asinh(sqrt((R/r1)^2-1));      % �ڲ�AG-CCT˫������ϵ��0
Cn1_0=D/1/sinh(eta01);      % �ڲ�AG-CCT�����ų�����ϵ��
Cn1_1=cot(alpha1)/2/sinh(eta01);      % �ڲ�AG-CCT�ļ��ų�����ϵ��
Cn1_2=S/3/sinh(eta01);      % �ڲ�AG-CCT�����ų�����ϵ��
Cn1_3=T/4/sinh(eta01);      % �ڲ�AG-CCT�˼��ų�����ϵ��

%-------���AG-CCT��Ʋ���-------
r2=0.065;     % ���AG-CCT��Ȧ�뾶
alpha2=pi-alpha1;      % ���AG-CCT���
I2=-I1;    % ���AG-CCT��Ȧ����ֵ
a2=sqrt(R*R-r2*r2);      % ���AG-CCT˫������ϵ�ļ���
eta02=asinh(sqrt((R/r2)^2-1));      % ���AG-CCT˫������ϵ��0
Cn2_0=-D/1/sinh(eta02);      % ���AG-CCT�����ų�����ϵ��
Cn2_1=cot(alpha2)/2/sinh(eta02);       % ���AG-CCT�ļ��ų�����ϵ��
Cn2_2=-S/3/sinh(eta02);       % ���AG-CCT�����ų�����ϵ��
Cn2_3=-T/4/sinh(eta02);       % ���AG-CCT�˼��ų�����ϵ��

%-----------AG-CCT����ģ�͵���Ʋ���-------------
length1=0.007;            % ��Ȧ�����ĳ���(m)
width1=0.002;             % ��Ȧ�����Ŀ��(m)
ln1=1;                   % ��Ȧ����泤�ȷ����ߵ�����
wn1=1;                 % ��Ȧ������ȷ����ߵ�����

delta1_w=width1/2/wn1;     % ��Ȧ������ȷ��������߼�����һ��
delta1_l=length1/2/ln1;    % ��Ȧ����泤�ȷ��������߼�����һ��
I1=I1/ln1/wn1;            % ����ģ��ÿ�����Ϸ�̯�ĵ���ֵ
I2=I2/ln1/wn1;

total_steps = int32(2.0*pi*N/step);

PathCenter1 = zeros(total_steps+1,3);            % define array to contain all center points in CCT path
PathCenterVector1_t = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->t
PathCenterVector1_r = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->r
PathCenterVector1_b = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->b

PathCenter2 = zeros(total_steps+1,3);            % define array to contain all center points in CCT path
PathCenterVector2_t = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->t
PathCenterVector2_r = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->r
PathCenterVector2_b = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->b

PathCenter3 = zeros(total_steps+1,3);            % define array to contain all center points in CCT path
PathCenterVector3_t = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->t
PathCenterVector3_r = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->r
PathCenterVector3_b = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->b

PathCenter4 = zeros(total_steps+1,3);            % define array to contain all center points in CCT path
PathCenterVector4_t = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->t
PathCenterVector4_r = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->r
PathCenterVector4_b = zeros(total_steps,3);      % define array to contain all vector (unit) in CCT central path; -->b


MultiLines_1 = zeros(total_steps+1,ln1,wn1,3);      % define array to contain multiple lines (ln*wn) in CCT path
MultiLines_2 = zeros(total_steps+1,ln1,wn1,3);      % define array to contain multiple lines (ln*wn) in CCT path


PathCenter1(1,:) = [a1*sinh(eta01)/(cosh(eta01)-cos(0))*cos(Cn1_0*sin(1*0)+Cn1_1*sin(2*0)+Cn1_2*sin(3*0)+Cn1_3*sin(4*0)+phi0/2/pi*0)
              a1*sinh(eta01)/(cosh(eta01)-cos(0))*sin(Cn1_0*sin(1*0)+Cn1_1*sin(2*0)+Cn1_2*sin(3*0)+Cn1_3*sin(4*0)+phi0/2/pi*0)
              a1*sin(0)/(cosh(eta01)-cos(0))];

for ksi=step:step:2*pi*N
     phi1 = Cn1_0*sin(1*ksi)+Cn1_1*sin(2*ksi)+Cn1_2*sin(3*ksi)+Cn1_3*sin(4*ksi)+phi0/2/pi*ksi;  % �ڲ�AG-CCT�ı��� ��(��)
     k1 = cosh(eta01)-cos(ksi);  %  �ڲ�AG-CCT·�������еĸ����� k(��)
     i=int32(ksi/step);
     
     PathCenter1(i+1,:) = [a1*sinh(eta01)/k1*cos(phi1)
     a1*sinh(eta01)/k1*sin(phi1)
     a1*sin(ksi)/k1];

     PathCenterVector1_t(i,:)=PathCenter1(i+1,:)-PathCenter1(i,:);
     PathCenterVector1_t(i,:)=PathCenterVector1_t(i,:)/norm(PathCenterVector1_t(i,:));     %�ڲ�AG-CCT��i���������ʸ��

     [angle1, rho1]=cart2pol(PathCenter1(i,1), PathCenter1(i,2));
     cur_CCT_Center1=[R*cos(angle1)  R*sin(angle1)  0];
     PathCenterVector1_r(i,:)=PathCenter1(i,:)-cur_CCT_Center1;
     PathCenterVector1_r(i,:)=PathCenterVector1_r(i,:)/norm(PathCenterVector1_r(i,:));     %�ڲ�AG-CCT��i����ľ���ʸ��

     PathCenterVector1_b(i,:)=cross(PathCenterVector1_t(i,:), PathCenterVector1_r(i,:));  
     PathCenterVector1_b(i,:)=PathCenterVector1_b(i,:)/norm(PathCenterVector1_b(i,:));    %�ڲ�AG-CCT��i����ĸ�����ʸ��

     for m=1:ln1
          delta1_r(m)=(2*(m-ln1/2)-1)*delta1_l;    % ����ģ��ÿ�����ھ����ϵ�����
          for k=1:wn1
               delta1_p(k)=(2*(k-wn1/2)-1)*delta1_w;    % ����ģ��ÿ�����ڸ������ϵ�����

               MultiLines_1(1,m,k,:)=[a1*sinh(eta01)/(cosh(eta01)-cos(0))*cos(Cn1_0*sin(1*0)+Cn1_1*sin(2*0)+Cn1_2*sin(3*0)+Cn1_3*sin(4*0)+phi0/2/pi*0)+delta1_r(m)*PathCenterVector1_r(1,1)+delta1_p(k)*PathCenterVector1_b(1,1);
                                                   a1*sinh(eta01)/(cosh(eta01)-cos(0))*sin(Cn1_0*sin(1*0)+Cn1_1*sin(2*0)+Cn1_2*sin(3*0)+Cn1_3*sin(4*0)+phi0/2/pi*0)+delta1_r(m)*PathCenterVector1_r(1,2)+delta1_p(k)*PathCenterVector1_b(1,2);
                                                   a1*sin(0)/(cosh(eta01)-cos(0))+delta1_r(m)*PathCenterVector1_r(1,3)+delta1_p(k)*PathCenterVector1_b(1,3)];
     
              MultiLines_1(i+1,m,k,:)=[a1*sinh(eta01)/k1*cos(phi1)+delta1_r(m)*PathCenterVector1_r(i,1)+delta1_p(k)*PathCenterVector1_b(i,1)
                                                     a1*sinh(eta01)/k1*sin(phi1)+delta1_r(m)*PathCenterVector1_r(i,2)+delta1_p(k)*PathCenterVector1_b(i,2)
                                                     a1*sin(ksi)/k1+delta1_r(m)*PathCenterVector1_r(i,3)+delta1_p(k)*PathCenterVector1_b(i,3)];
        end
     end

end

PathCenter2(1,:) = [a2*sinh(eta02)/(cosh(eta02)-cos(0))*cos(Cn2_0*sin(1*0)+Cn2_1*sin(2*0)+Cn2_2*sin(3*0)+Cn2_3*sin(4*0)+phi0/2/pi*0)
              a2*sinh(eta02)/(cosh(eta02)-cos(0))*sin(Cn2_0*sin(1*0)+Cn2_1*sin(2*0)+Cn2_2*sin(3*0)+Cn2_3*sin(4*0)+phi0/2/pi*0)
              a2*sin(0)/(cosh(eta02)-cos(0))];

for ksi=step:step:2*pi*N
     phi2=Cn2_0*sin(1*ksi)+Cn2_1*sin(2*ksi)+Cn2_2*sin(3*ksi)+Cn2_3*sin(4*ksi)+phi0/2/pi*ksi;  % ���AG-CCT�ı��� ��(��)
     k2=cosh(eta02)-cos(ksi);  %  ���AG-CCT·�������еĸ����� k(��)
     i=int32(ksi/step);
     
     PathCenter2(i+1,:)=[a2*sinh(eta02)/k2*cos(phi2)
     a2*sinh(eta02)/k2*sin(phi2)
     a2*sin(ksi)/k2];

     PathCenterVector2_t(i,:)=PathCenter2(i+1,:)-PathCenter2(i,:);
     PathCenterVector2_t(i,:)=PathCenterVector2_t(i,:)/norm(PathCenterVector2_t(i,:));     % ���AG-CCT��i���������ʸ��

     [angle2, rho2]=cart2pol(PathCenter2(i,1), PathCenter2(i,2));
     cur_CCT_Center2=[R*cos(angle2)  R*sin(angle2)  0];
     PathCenterVector2_r(i,:)=PathCenter2(i,:)-cur_CCT_Center2;
     PathCenterVector2_r(i,:)=PathCenterVector2_r(i,:)/norm(PathCenterVector2_r(i,:));     % ���AG-CCT��i����ľ���ʸ��

     PathCenterVector2_b(i,:)=cross(PathCenterVector2_t(i,:), PathCenterVector2_r(i,:));  
     PathCenterVector2_b(i,:)=PathCenterVector2_b(i,:)/norm(PathCenterVector2_b(i,:));    % ���AG-CCT��i����ĸ�����ʸ��

     for m=1:ln1
          delta2_r(m)=(2*(m-ln1/2)-1)*delta1_l;    % ����ģ��ÿ�����ھ����ϵ�����
          for k=1:wn1
               delta2_p(k)=(2*(k-wn1/2)-1)*delta1_w;    % ����ģ��ÿ�����ڸ������ϵ�����

               MultiLines_2(1,m,k,:)=[a2*sinh(eta02)/(cosh(eta02)-cos(0))*cos(Cn2_0*sin(1*0)+Cn2_1*sin(2*0)+Cn2_2*sin(3*0)+Cn2_3*sin(4*0)+phi0/2/pi*0)+delta2_r(m)*PathCenterVector2_r(1,1)+delta2_p(k)*PathCenterVector2_b(1,1);
                                                   a2*sinh(eta02)/(cosh(eta02)-cos(0))*sin(Cn2_0*sin(1*0)+Cn2_1*sin(2*0)+Cn2_2*sin(3*0)+Cn2_3*sin(4*0)+phi0/2/pi*0)+delta2_r(m)*PathCenterVector2_r(1,2)+delta2_p(k)*PathCenterVector2_b(1,2);
                                                   a2*sin(0)/(cosh(eta02)-cos(0))+delta2_r(m)*PathCenterVector2_r(1,3)+delta2_p(k)*PathCenterVector2_b(1,3)];
     
              MultiLines_2(i+1,m,k,:)=[a2*sinh(eta02)/k2*cos(phi2)+delta2_r(m)*PathCenterVector2_r(i,1)+delta2_p(k)*PathCenterVector2_b(i,1)
                                                     a2*sinh(eta02)/k2*sin(phi2)+delta2_r(m)*PathCenterVector2_r(i,2)+delta2_p(k)*PathCenterVector2_b(i,2)
                                                     a2*sin(ksi)/k2+delta2_r(m)*PathCenterVector2_r(i,3)+delta2_p(k)*PathCenterVector2_b(i,3)];
        end
     end

end

%-------�ڲ����CCT��Ʋ���-------
r3=0.075;      % �ڲ����CCT��Ȧ�뾶
alpha3=32.5*pi/180;      % �ڲ����CCT���
G1=0.08015;     % �ڲ����CCT�ļ��ų�����
S1=0.0039;     %�ڲ����CCT�����ų�����
T1=0.000;     %�ڲ����CCT�˼��ų�����
I3=3818.4;
a3=sqrt(R*R-r3*r3);    % �ڲ����CCT˫������ϵ�ļ���
eta03=asinh(sqrt((R/r3)^2-1));  % �ڲ����CCT˫������ϵ��0
Cn3_0=cot(alpha3)/1/sinh(eta03);   % �ڲ����CCT�����ų�����ϵ��
Cn3_1=G1/2/sinh(eta03);     % �ڲ����CCT�ļ��ų�����ϵ��
Cn3_2=S1/3/sinh(eta03);     % �ڲ����CCT�����ų�����ϵ��
Cn3_3=T1/4/sinh(eta03);     % �ڲ����CCT�˼��ų�����ϵ��

%-------������CCT��Ʋ���-------
r4=0.085;      % ������CCT��Ȧ�뾶
alpha4=pi-alpha3;      % ������CCT���
I4=-I3;
a4=sqrt(R*R-r4*r4);    % ������CCT˫������ϵ�ļ���
eta04=asinh(sqrt((R/r4)^2-1));  % ������CCT˫������ϵ��0
Cn4_0=cot(alpha4)/1/sinh(eta04);   % ������CCT�����ų�����ϵ��
Cn4_1=-G1/2/sinh(eta04);     % ������CCT�ļ��ų�����ϵ��
Cn4_2=-S1/3/sinh(eta04);     % ������CCT�����ų�����ϵ��
Cn4_3=-T1/4/sinh(eta04);     % ������CCT�˼��ų�����ϵ��

%-----------����CCT����ģ�͵���Ʋ���-------------
length2=0.007;            % ��Ȧ�����ĳ���(m)
width2=0.002;             % ��Ȧ�����Ŀ��(m)
ln2=1;                   % ��Ȧ����泤�ȷ����ߵ�����
wn2=1;                 % ��Ȧ������ȷ����ߵ�����

delta2_w=width2/2/wn2;     % ��Ȧ������ȷ��������߼�����һ��
delta2_l=length2/2/ln2;    % ��Ȧ����泤�ȷ��������߼�����һ��
I3=I3/ln2/wn2;            % ����ģ��ÿ�����Ϸ�̯�ĵ���ֵ
I4=I4/ln2/wn2;

MultiLines_3 = zeros(total_steps+1,ln2,wn2,3);      % define array to contain multiple lines (ln*wn) in CCT path
MultiLines_4 = zeros(total_steps+1,ln2,wn2,3);      % define array to contain multiple lines (ln*wn) in CCT path




PathCenter3(1,:) = [a3*sinh(eta03)/(cosh(eta03)-cos(0))*cos(Cn3_0*sin(1*0)+Cn3_1*sin(2*0)+Cn3_2*sin(3*0)+Cn3_3*sin(4*0)+phi0/2/pi*0)
              a3*sinh(eta03)/(cosh(eta03)-cos(0))*sin(Cn3_0*sin(1*0)+Cn3_1*sin(2*0)+Cn3_2*sin(3*0)+Cn3_3*sin(4*0)+phi0/2/pi*0)
              a3*sin(0)/(cosh(eta03)-cos(0))];

for ksi=step:step:2*pi*N
     phi3=Cn3_0*sin(1*ksi)+Cn3_1*sin(2*ksi)+Cn3_2*sin(3*ksi)+Cn3_3*sin(4*ksi)+phi0/2/pi*ksi;  % �ڲ����CCT�ı��� ��(��)
     k3=cosh(eta03)-cos(ksi);  %  �ڲ����·�������еĸ����� k(��)
     i=int32(ksi/step);
     
     PathCenter3(i+1,:) = [a3*sinh(eta03)/k3*cos(phi3)
     a3*sinh(eta03)/k3*sin(phi3)
     a3*sin(ksi)/k3];

     PathCenterVector3_t(i,:)=PathCenter3(i+1,:)-PathCenter3(i,:);
     PathCenterVector3_t(i,:)=PathCenterVector3_t(i,:)/norm(PathCenterVector3_t(i,:));     %�ڲ����CCT��i���������ʸ��

     [angle3, rho3]=cart2pol(PathCenter3(i,1), PathCenter3(i,2));
     cur_CCT_Center3=[R*cos(angle3)  R*sin(angle3)  0];
     PathCenterVector3_r(i,:)=PathCenter3(i,:)-cur_CCT_Center3;
     PathCenterVector3_r(i,:)=PathCenterVector3_r(i,:)/norm(PathCenterVector3_r(i,:));     %�ڲ����CCT��i����ľ���ʸ��

     PathCenterVector3_b(i,:)=cross(PathCenterVector3_t(i,:), PathCenterVector3_r(i,:));  
     PathCenterVector3_b(i,:)=PathCenterVector3_b(i,:)/norm(PathCenterVector3_b(i,:));    %�ڲ����CCT��i����ĸ�����ʸ��

     for m=1:ln2
          delta3_r(m)=(2*(m-ln2/2)-1)*delta2_l;    % ����ģ��ÿ�����ھ����ϵ�����
          for k=1:wn2
               delta3_p(k)=(2*(k-wn2/2)-1)*delta2_w;    % ����ģ��ÿ�����ڸ������ϵ�����

               MultiLines_3(1,m,k,:)=[a3*sinh(eta03)/(cosh(eta03)-cos(0))*cos(Cn3_0*sin(1*0)+Cn3_1*sin(2*0)+Cn3_2*sin(3*0)+Cn3_3*sin(4*0)+phi0/2/pi*0)+delta3_r(m)*PathCenterVector3_r(1,1)+delta3_p(k)*PathCenterVector3_b(1,1);
                                                   a3*sinh(eta03)/(cosh(eta03)-cos(0))*sin(Cn3_0*sin(1*0)+Cn3_1*sin(2*0)+Cn3_2*sin(3*0)+Cn3_3*sin(4*0)+phi0/2/pi*0)+delta3_r(m)*PathCenterVector3_r(1,2)+delta3_p(k)*PathCenterVector3_b(1,2);
                                                   a3*sin(0)/(cosh(eta03)-cos(0))+delta3_r(m)*PathCenterVector3_r(1,3)+delta3_p(k)*PathCenterVector3_b(1,3)];
     
              MultiLines_3(i+1,m,k,:)=[a3*sinh(eta03)/k3*cos(phi3)+delta3_r(m)*PathCenterVector3_r(i,1)+delta3_p(k)*PathCenterVector3_b(i,1)
                                                     a3*sinh(eta03)/k3*sin(phi3)+delta3_r(m)*PathCenterVector3_r(i,2)+delta3_p(k)*PathCenterVector3_b(i,2)
                                                     a3*sin(ksi)/k3+delta3_r(m)*PathCenterVector3_r(i,3)+delta3_p(k)*PathCenterVector3_b(i,3)];
        end
     end

end

PathCenter4(1,:) = [a4*sinh(eta04)/(cosh(eta04)-cos(0))*cos(Cn4_0*sin(1*0)+Cn4_1*sin(2*0)+Cn4_2*sin(3*0)+Cn4_3*sin(4*0)+phi0/2/pi*0)
              a4*sinh(eta04)/(cosh(eta04)-cos(0))*sin(Cn4_0*sin(1*0)+Cn4_1*sin(2*0)+Cn4_2*sin(3*0)+Cn4_3*sin(4*0)+phi0/2/pi*0)
              a4*sin(0)/(cosh(eta04)-cos(0))];

for ksi=step:step:2*pi*N
     phi4=Cn4_0*sin(1*ksi)+Cn4_1*sin(2*ksi)+Cn4_2*sin(3*ksi)+Cn4_3*sin(4*ksi)+phi0/2/pi*ksi;  % ������CCT�ı��� ��(��)
     k4=cosh(eta04)-cos(ksi);  %  ������CCT·�������еĸ����� k(��)
     i=int32(ksi/step);
     
     PathCenter4(i+1,:)=[a4*sinh(eta04)/k4*cos(phi4)
     a4*sinh(eta04)/k4*sin(phi4)
     a4*sin(ksi)/k4];

     PathCenterVector4_t(i,:)=PathCenter4(i+1,:)-PathCenter4(i,:);
     PathCenterVector4_t(i,:)=PathCenterVector4_t(i,:)/norm(PathCenterVector4_t(i,:));     % ������CCT��i���������ʸ��

     [angle4, rho4]=cart2pol(PathCenter4(i,1), PathCenter4(i,2));
     cur_CCT_Center4=[R*cos(angle4)  R*sin(angle4)  0];
     PathCenterVector4_r(i,:)=PathCenter4(i,:)-cur_CCT_Center4;
     PathCenterVector4_r(i,:)=PathCenterVector4_r(i,:)/norm(PathCenterVector4_r(i,:));     % ������CCT��i����ľ���ʸ��

     PathCenterVector4_b(i,:)=cross(PathCenterVector4_t(i,:), PathCenterVector4_r(i,:));  
     PathCenterVector4_b(i,:)=PathCenterVector4_b(i,:)/norm(PathCenterVector4_b(i,:));    % ������CCT��i����ĸ�����ʸ��

     for m=1:ln2
          delta4_r(m)=(2*(m-ln2/2)-1)*delta2_l;    % ����ģ��ÿ�����ھ����ϵ�����
          for k=1:wn2
               delta4_p(k)=(2*(k-wn2/2)-1)*delta2_w;    % ����ģ��ÿ�����ڸ������ϵ�����

               MultiLines_4(1,m,k,:)=[a4*sinh(eta04)/(cosh(eta04)-cos(0))*cos(Cn4_0*sin(1*0)+Cn4_1*sin(2*0)+Cn4_2*sin(3*0)+Cn4_3*sin(4*0)+phi0/2/pi*0)+delta4_r(m)*PathCenterVector4_r(1,1)+delta4_p(k)*PathCenterVector4_b(1,1);
                                                   a4*sinh(eta04)/(cosh(eta04)-cos(0))*sin(Cn4_0*sin(1*0)+Cn4_1*sin(2*0)+Cn4_2*sin(3*0)+Cn4_3*sin(4*0)+phi0/2/pi*0)+delta4_r(m)*PathCenterVector4_r(1,2)+delta4_p(k)*PathCenterVector4_b(1,2);
                                                   a4*sin(0)/(cosh(eta04)-cos(0))+delta4_r(m)*PathCenterVector4_r(1,3)+delta4_p(k)*PathCenterVector4_b(1,3)];
     
             MultiLines_4(i+1,m,k,:)=[a4*sinh(eta04)/k4*cos(phi4)+delta4_r(m)*PathCenterVector4_r(i,1)+delta4_p(k)*PathCenterVector4_b(i,1)
                                                      a4*sinh(eta04)/k4*sin(phi4)+delta4_r(m)*PathCenterVector4_r(i,2)+delta4_p(k)*PathCenterVector4_b(i,2)
                                                     a4*sin(ksi)/k4+delta4_r(m)*PathCenterVector4_r(i,3)+delta4_p(k)*PathCenterVector4_b(i,3)];
        end
     end

end

t2=clock;


axis equal
% PAUSE!!!!

%%% FieldCalcuType: 1, field at constant Large Radius; 2, field at local
%%% circle -- corresponding to CCT aperture

FieldCalcuType = 1;

if FieldCalcuType == 1
    Rho_calculation=R+r1-0.002;
    Z=0;
    start_angle=-10; 
    end_angle=80;
    Calcu_pointsNum=91;
    CalcuFieldAtRadius(Rho_calculation, Z, start_angle, end_angle, Calcu_pointsNum);
elseif FieldCalcuType == 2
    Calcu_theta=37.5;
    Calcu_apertureRadius=0.005;
    Calcu_pointsNum=36;
    CalcuFieldAtApertureCircle( Calcu_theta,  Calcu_apertureRadius, Calcu_pointsNum);
end


 t3=clock;
 tx=etime(t2,t1)/60;
 tol=etime(t3,t1)/60;

%% B field of Two Layers Curved CCT Calculation!   / ����������� Calcu_theta��CCT�׾� Calcu_apertureRadius�� Bx,y,z,Mod
function CalcuFieldAtApertureCircle(Calcu_theta, Calcu_apertureRadius, Calcu_pointsNum)
    %-----------����Բ���ϴų�����-------------
    
    global N;
    global I1;
    global I2;
    global I3;
    global I4;
    global step;
    global total_steps;
    global miu;
    global R;
    
    global ln1;
    global ln2;
    global wn1;
    global wn2;
    
    global MultiLines_1;
    global MultiLines_2;
    global MultiLines_3;
    global MultiLines_4;
    
    N1=62;     % ��һ������
    N2=73;     % �ڶ�������
    N3=77;     % ����������
    N4=73;     % ���Ķ�����
    N5=62;     % ���������

    dB1 = zeros(total_steps,3);
    sumdB1 = zeros(1,3);
    sumdB1x=zeros(wn2,ln2);
    sumdB1y=zeros(wn2,ln2);
    sumdB1z=zeros(wn2,ln2);
    B1x=zeros(Calcu_pointsNum,1);
    B1y=zeros(Calcu_pointsNum,1);
    B1z=zeros(Calcu_pointsNum,1);
    
    dB2 = zeros(total_steps,3);
    sumdB2 = zeros(1,3);
    sumdB2x=zeros(wn1,ln1);
    sumdB2y=zeros(wn1,ln1);
    sumdB2z=zeros(wn1,ln1);
    B2x=zeros(Calcu_pointsNum,1);
    B2y=zeros(Calcu_pointsNum,1);
    B2z=zeros(Calcu_pointsNum,1);
    
    dB3 = zeros(total_steps,3);
    sumdB3 = zeros(1,3);
    sumdB3x=zeros(wn1,ln1);
    sumdB3y=zeros(wn1,ln1);
    sumdB3z=zeros(wn1,ln1);
    B3x=zeros(Calcu_pointsNum,1);
    B3y=zeros(Calcu_pointsNum,1);
    B3z=zeros(Calcu_pointsNum,1);
    
    dB4 = zeros(total_steps,3);
    sumdB4 = zeros(1,3);
    sumdB4x=zeros(wn1,ln1);
    sumdB4y=zeros(wn1,ln1);
    sumdB4z=zeros(wn1,ln1);
    B4x=zeros(Calcu_pointsNum,1);
    B4y=zeros(Calcu_pointsNum,1);
    B4z=zeros(Calcu_pointsNum,1);
    
    
    %B_total = zeros(Calcu_pointsNum,4);    % STORE Bmod for 4th element
    Bmod=zeros(Calcu_pointsNum,1);
    B=zeros(3,Calcu_pointsNum);
    
    MultiLines_1_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_1_r=zeros(total_steps,ln2,wn2,3);
    MultiLines_2_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_2_r=zeros(total_steps,ln2,wn2,3);
    MultiLines_3_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_3_r=zeros(total_steps,ln2,wn2,3);
    MultiLines_4_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_4_r=zeros(total_steps,ln2,wn2,3);
    
    R
    CalcuPoint=zeros(Calcu_pointsNum,3);
    angle=linspace(360.0/Calcu_pointsNum, 360.0, Calcu_pointsNum);
    for t=1:Calcu_pointsNum
        cur_phi = t * 360.0/Calcu_pointsNum * (pi/180.0);
        cur_R = R + Calcu_apertureRadius * cos(cur_phi);
        cur_Z = Calcu_apertureRadius * sin(cur_phi);
        CalcuPoint(t,:)=[cur_R * cos(Calcu_theta * (pi/180.0)); cur_R * sin(Calcu_theta * (pi/180.0)); cur_Z];
        
        waitbar(t/Calcu_pointsNum)
    
      for m=1:ln2
          for k=1:wn2
                for ksi=step:step:N1*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I1*multi/A_r/A_r; 
                end
                for ksi=(step+N1*2*pi):step:(N1+N2)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I2*multi/A_r/A_r; 
                end
                for ksi=(step+(N1+N2)*2*pi):step:(N1+N2+N3)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I1*multi/A_r/A_r; 
                end
                for ksi=(step+(N1+N2+N3)*2*pi):step:(N1+N2+N3+N4)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I2*multi/A_r/A_r; 
                end
                for ksi=(step+(N1+N2+N3+N4)*2*pi):step:(N1+N2+N3+N4+N5)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I1*multi/A_r/A_r; 
                end
                sumdB1=sum(dB1,1);
                sumdB1x(k,m)=sumdB1(1);
                sumdB1y(k,m)=sumdB1(2);
                sumdB1z(k,m)=sumdB1(3);
            end
        end
        B1x(t)=sum(sum(sumdB1x));
        B1y(t)=sum(sum(sumdB1y));
        B1z(t)=sum(sum(sumdB1z));
        for m=1:ln1
            for k=1:wn1
                for ksi=step:step:N1*2*pi 
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I2*multi/A_r/A_r;
                end
                for ksi=(step+N1*2*pi):step:(N1+N2)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I1*multi/A_r/A_r;
                end
                for ksi=(step+(N1+N2)*2*pi):step:(N1+N2+N3)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I2*multi/A_r/A_r;
                end
                for ksi=(step+(N1+N2+N3)*2*pi):step:(N1+N2+N3+N4)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I1*multi/A_r/A_r;
                end
                for ksi=(step+(N1+N2+N3+N4)*2*pi):step:(N1+N2+N3+N4+N5)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I2*multi/A_r/A_r;
                end
                sumdB2=sum(dB2,1);
                sumdB2x(k,m)=sumdB2(1);
                sumdB2y(k,m)=sumdB2(2);
                sumdB2z(k,m)=sumdB2(3);
            end
        end
        B2x(t)=sum(sum(sumdB2x));
        B2y(t)=sum(sum(sumdB2y));
        B2z(t)=sum(sum(sumdB2z));
        for m=1:ln2
          for k=1:wn2
                for ksi=step:step:N*2*pi 
                    i=int32(ksi/step);
                    MultiLines_3_i(i,m,k,:)=MultiLines_3(i+1,m,k,:)-MultiLines_3(i,m,k,:);
                    MultiLines_3_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_3(i,m,k,1)+MultiLines_3(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_3(i,m,k,2)+MultiLines_3(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_3(i,m,k,3)+MultiLines_3(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_3_r(i,m,k,1)*MultiLines_3_r(i,m,k,1)+MultiLines_3_r(i,m,k,2)*MultiLines_3_r(i,m,k,2)+MultiLines_3_r(i,m,k,3)*MultiLines_3_r(i,m,k,3));
                    er=MultiLines_3_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_3_i(i,m,k,:), er);
                    dB3(i,:)=miu/4/pi*I3*multi/A_r/A_r; 
                end
                sumdB3=sum(dB3,1);
                sumdB3x(k,m)=sumdB3(1);
                sumdB3y(k,m)=sumdB3(2);
                sumdB3z(k,m)=sumdB3(3);
            end
        end
        B3x(t)=sum(sum(sumdB3x));
        B3y(t)=sum(sum(sumdB3y));
        B3z(t)=sum(sum(sumdB3z));
        for m=1:ln2
          for k=1:wn2
                for ksi=step:step:N*2*pi 
                    i=int32(ksi/step);
                    MultiLines_4_i(i,m,k,:)=MultiLines_4(i+1,m,k,:)-MultiLines_4(i,m,k,:);
                    MultiLines_4_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_4(i,m,k,1)+MultiLines_4(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_4(i,m,k,2)+MultiLines_4(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_4(i,m,k,3)+MultiLines_4(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_4_r(i,m,k,1)*MultiLines_4_r(i,m,k,1)+MultiLines_4_r(i,m,k,2)*MultiLines_4_r(i,m,k,2)+MultiLines_4_r(i,m,k,3)*MultiLines_4_r(i,m,k,3));
                    er=MultiLines_4_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_4_i(i,m,k,:), er);
                    dB4(i,:)=miu/4/pi*I4*multi/A_r/A_r; 
                end
                sumdB4=sum(dB4,1);
                sumdB4x(k,m)=sumdB4(1);
                sumdB4y(k,m)=sumdB4(2);
                sumdB4z(k,m)=sumdB4(3);
            end
        end
        B4x(t)=sum(sum(sumdB4x));
        B4y(t)=sum(sum(sumdB4y));
        B4z(t)=sum(sum(sumdB4z));
        B(:,t)=[B1x(t)+B2x(t)+B3x(t)+B4x(t); 
                  B1y(t)+B2y(t)+B3y(t)+B4y(t); 
                  B1z(t)+B2z(t)+B3z(t)+B4z(t)];
        Bmod(t)=sqrt(B(1,t)^2+B(2,t)^2+B(3,t)^2);

    end


    
    figure(2)
    hold on

    line_Bx = plot(angle, B(1,:),'-^g','LineWidth',1);
    line_By = plot(angle, B(2,:),'-xr','LineWidth',2);
    line_Bz = plot(angle, B(3,:),'--ob', 'LineWidth',2);
    line_Bmod = plot(angle, Bmod,'--*k', 'LineWidth',2);
   

    xlabel('s (m)','Fontname', 'Times New Roman','FontSize',18);
    ylabel('B (T)','Fontname', 'Times New Roman','FontSize',18);
    legend('Bx', 'By', 'Bz', 'Bmod')
    set(gca,'FontSize',13);
    grid on
    
    
end  


%% B field of Two Layers Curved CCT Calculation!   / �����ڰ뾶 Rho_calculation��z=Z ���� [start_angle - end_angle] ��Χ Bx,y,z,Mod
%% CalcuCurveField(Rho_calculation, Z, angle_s, angle_e, point_num)
function CalcuFieldAtRadius(Rho_calculation, Z, start_angle, end_angle, Calcu_pointsNum)
    %-----------����Բ���ϴų�����-------------
    global N;
    global I1;
    global I2;
    global I3;
    global I4;
    global step;
    global total_steps;
    global miu;
    global R;
    
    global ln1;
    global ln2;
    global wn1;
    global wn2;
    
    global MultiLines_1;
    global MultiLines_2;
    global MultiLines_3;
    global MultiLines_4;

    N1=62;     % ��һ������
    N2=73;     % �ڶ�������
    N3=77;     % ����������
    N4=73;     % ���Ķ�����
    N5=62;     % ���������
    
    dB1 = zeros(total_steps,3);
    sumdB1 = zeros(1,3);
    sumdB1x=zeros(wn2,ln2);
    sumdB1y=zeros(wn2,ln2);
    sumdB1z=zeros(wn2,ln2);
    B1x=zeros(Calcu_pointsNum,1);
    B1y=zeros(Calcu_pointsNum,1);
    B1z=zeros(Calcu_pointsNum,1);
    
    dB2 = zeros(total_steps,3);
    sumdB2 = zeros(1,3);
    sumdB2x=zeros(wn1,ln1);
    sumdB2y=zeros(wn1,ln1);
    sumdB2z=zeros(wn1,ln1);
    B2x=zeros(Calcu_pointsNum,1);
    B2y=zeros(Calcu_pointsNum,1);
    B2z=zeros(Calcu_pointsNum,1);
    
    dB3 = zeros(total_steps,3);
    sumdB3 = zeros(1,3);
    sumdB3x=zeros(wn1,ln1);
    sumdB3y=zeros(wn1,ln1);
    sumdB3z=zeros(wn1,ln1);
    B3x=zeros(Calcu_pointsNum,1);
    B3y=zeros(Calcu_pointsNum,1);
    B3z=zeros(Calcu_pointsNum,1);
    
    dB4 = zeros(total_steps,3);
    sumdB4 = zeros(1,3);
    sumdB4x=zeros(wn1,ln1);
    sumdB4y=zeros(wn1,ln1);
    sumdB4z=zeros(wn1,ln1);
    B4x=zeros(Calcu_pointsNum,1);
    B4y=zeros(Calcu_pointsNum,1);
    B4z=zeros(Calcu_pointsNum,1);
    
    
    %B_total = zeros(Calcu_pointsNum,4);    % STORE Bmod for 4th element
    Bmod=zeros(Calcu_pointsNum,1);
    B=zeros(3,Calcu_pointsNum);
    
    MultiLines_1_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_1_r=zeros(total_steps,ln2,wn2,3);
    MultiLines_2_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_2_r=zeros(total_steps,ln2,wn2,3);
    MultiLines_3_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_3_r=zeros(total_steps,ln2,wn2,3);
    MultiLines_4_i=zeros(total_steps,ln2,wn2,3);
    MultiLines_4_r=zeros(total_steps,ln2,wn2,3);
    
    CalcuPoint=zeros(Calcu_pointsNum,3);
    delta_angle=(end_angle-start_angle)/(Calcu_pointsNum-1);
    angle=linspace(start_angle, end_angle, Calcu_pointsNum);
    
    for t=1:Calcu_pointsNum
        CalcuPoint(t,:)=[Rho_calculation*cos((start_angle+delta_angle*(t-1))/180*pi); Rho_calculation*sin((start_angle+delta_angle*(t-1))/180*pi); Z];

        waitbar(t/Calcu_pointsNum)
   
      for m=1:ln2
          for k=1:wn2
                for ksi=step:step:N1*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I1*multi/A_r/A_r; 
                end
                for ksi=(step+N1*2*pi):step:(N1+N2)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I2*multi/A_r/A_r; 
                end
                for ksi=(step+(N1+N2)*2*pi):step:(N1+N2+N3)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I1*multi/A_r/A_r; 
                end
                for ksi=(step+(N1+N2+N3)*2*pi):step:(N1+N2+N3+N4)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I2*multi/A_r/A_r; 
                end
                for ksi=(step+(N1+N2+N3+N4)*2*pi):step:(N1+N2+N3+N4+N5)*2*pi 
                    i=int32(ksi/step);
                    MultiLines_1_i(i,m,k,:)=MultiLines_1(i+1,m,k,:)-MultiLines_1(i,m,k,:);
                    MultiLines_1_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_1(i,m,k,1)+MultiLines_1(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_1(i,m,k,2)+MultiLines_1(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_1(i,m,k,3)+MultiLines_1(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_1_r(i,m,k,1)*MultiLines_1_r(i,m,k,1)+MultiLines_1_r(i,m,k,2)*MultiLines_1_r(i,m,k,2)+MultiLines_1_r(i,m,k,3)*MultiLines_1_r(i,m,k,3));
                    er=MultiLines_1_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_1_i(i,m,k,:), er);
                    dB1(i,:)=miu/4/pi*I1*multi/A_r/A_r; 
                end
                sumdB1=sum(dB1,1);
                sumdB1x(k,m)=sumdB1(1);
                sumdB1y(k,m)=sumdB1(2);
                sumdB1z(k,m)=sumdB1(3);
            end
        end
        B1x(t)=sum(sum(sumdB1x));
        B1y(t)=sum(sum(sumdB1y));
        B1z(t)=sum(sum(sumdB1z));
        for m=1:ln1
            for k=1:wn1
                for ksi=step:step:N1*2*pi 
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I2*multi/A_r/A_r;
                end
                for ksi=(step+N1*2*pi):step:(N1+N2)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I1*multi/A_r/A_r;
                end
                for ksi=(step+(N1+N2)*2*pi):step:(N1+N2+N3)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I2*multi/A_r/A_r;
                end
                for ksi=(step+(N1+N2+N3)*2*pi):step:(N1+N2+N3+N4)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I1*multi/A_r/A_r;
                end
                for ksi=(step+(N1+N2+N3+N4)*2*pi):step:(N1+N2+N3+N4+N5)*2*pi   
                    i=int32(ksi/step);
                    MultiLines_2_i(i,m,k,:)=MultiLines_2(i+1,m,k,:)-MultiLines_2(i,m,k,:);
                    MultiLines_2_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_2(i,m,k,1)+MultiLines_2(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_2(i,m,k,2)+MultiLines_2(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_2(i,m,k,3)+MultiLines_2(i+1,m,k,3))/2];
                    A_r=sqrt(MultiLines_2_r(i,m,k,1)*MultiLines_2_r(i,m,k,1)+MultiLines_2_r(i,m,k,2)*MultiLines_2_r(i,m,k,2)+MultiLines_2_r(i,m,k,3)*MultiLines_2_r(i,m,k,3));
                    er=MultiLines_2_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_2_i(i,m,k,:), er);
                    dB2(i,:)=miu/4/pi*I2*multi/A_r/A_r;
                end
                sumdB2=sum(dB2,1);
                sumdB2x(k,m)=sumdB2(1);
                sumdB2y(k,m)=sumdB2(2);
                sumdB2z(k,m)=sumdB2(3);
            end
        end
        B2x(t)=sum(sum(sumdB2x));
        B2y(t)=sum(sum(sumdB2y));
        B2z(t)=sum(sum(sumdB2z));
        for m=1:ln2
          for k=1:wn2
                for ksi=step:step:N*2*pi 
                    i=int32(ksi/step);
                    MultiLines_3_i(i,m,k,:)=MultiLines_3(i+1,m,k,:)-MultiLines_3(i,m,k,:);
                    MultiLines_3_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_3(i,m,k,1)+MultiLines_3(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_3(i,m,k,2)+MultiLines_3(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_3(i,m,k,3)+MultiLines_3(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_3_r(i,m,k,1)*MultiLines_3_r(i,m,k,1)+MultiLines_3_r(i,m,k,2)*MultiLines_3_r(i,m,k,2)+MultiLines_3_r(i,m,k,3)*MultiLines_3_r(i,m,k,3));
                    er=MultiLines_3_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_3_i(i,m,k,:), er);
                    dB3(i,:)=miu/4/pi*I3*multi/A_r/A_r; 
                end
                sumdB3=sum(dB3,1);
                sumdB3x(k,m)=sumdB3(1);
                sumdB3y(k,m)=sumdB3(2);
                sumdB3z(k,m)=sumdB3(3);
            end
        end
        B3x(t)=sum(sum(sumdB3x));
        B3y(t)=sum(sum(sumdB3y));
        B3z(t)=sum(sum(sumdB3z));
        for m=1:ln2
          for k=1:wn2
                for ksi=step:step:N*2*pi 
                    i=int32(ksi/step);
                    MultiLines_4_i(i,m,k,:)=MultiLines_4(i+1,m,k,:)-MultiLines_4(i,m,k,:);
                    MultiLines_4_r(i,m,k,:)=[CalcuPoint(t,1)-(MultiLines_4(i,m,k,1)+MultiLines_4(i+1,m,k,1))/2
                                                        CalcuPoint(t,2)-(MultiLines_4(i,m,k,2)+MultiLines_4(i+1,m,k,2))/2
                                                        CalcuPoint(t,3)-(MultiLines_4(i,m,k,3)+MultiLines_4(i,m,k,3))/2];
                    A_r=sqrt(MultiLines_4_r(i,m,k,1)*MultiLines_4_r(i,m,k,1)+MultiLines_4_r(i,m,k,2)*MultiLines_4_r(i,m,k,2)+MultiLines_4_r(i,m,k,3)*MultiLines_4_r(i,m,k,3));
                    er=MultiLines_4_r(i,m,k,:)/A_r;
                    multi=cross(MultiLines_4_i(i,m,k,:), er);
                    dB4(i,:)=miu/4/pi*I4*multi/A_r/A_r; 
                end
                sumdB4=sum(dB4,1);
                sumdB4x(k,m)=sumdB4(1);
                sumdB4y(k,m)=sumdB4(2);
                sumdB4z(k,m)=sumdB4(3);
            end
        end
        B4x(t)=sum(sum(sumdB4x));
        B4y(t)=sum(sum(sumdB4y));
        B4z(t)=sum(sum(sumdB4z));
        B(:,t)=[B1x(t)+B2x(t)+B3x(t)+B4x(t); 
                  B1y(t)+B2y(t)+B3y(t)+B4y(t); 
                  B1z(t)+B2z(t)+B3z(t)+B4z(t)];
        Bmod(t)=sqrt(B(1,t)^2+B(2,t)^2+B(3,t)^2);

    end

    
    figure(8)
    hold on

    line_Bx = plot(angle, B(1,:),'-^g','LineWidth',1);
    line_By = plot(angle, B(2,:),'-xr','LineWidth',2);
    line_Bz = plot(angle, B(3,:),'--ob', 'LineWidth',2);
    line_Bmod = plot(angle, Bmod,'--*k', 'LineWidth',2);
   

    xlabel('s (m)','Fontname', 'Times New Roman','FontSize',18);
    ylabel('B (T)','Fontname', 'Times New Roman','FontSize',18);
    legend('Bx', 'By', 'Bz', 'Bmod')
    set(gca,'FontSize',13);
    grid on
 
    
end
