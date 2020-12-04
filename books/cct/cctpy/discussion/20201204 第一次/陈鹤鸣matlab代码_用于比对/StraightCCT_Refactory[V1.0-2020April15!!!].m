% Straight CCT / 2 Layers, Refactoring Version, 2020 April 13  %%

close all;clear;clc

%-----------������תCCT����Ʋ���-------------
global N;
global I1;
global I2;
global ln;
global wn;
global step;
global miu;

dTheta=1.0;
step = dTheta * pi / 180;           %CCT�Ĳ���

omega_i=0.01;                           %CCT���Ѽ�࣬unit: m
r1=0.06;                                     %�ڲ�CCT/Layer1 �׾��뾶, unit: m
r2=0.08;                                     %���CCT/Layer2 �׾��뾶, unit: m
alpha1=20.0;                              %�ڲ�CCT/Layer1 ��б�� Alpha1, unit: deg.
alpha2=180-alpha1;                   %���CCT/Layer1 ��б�� Alpha2=180-Alpha1, unit: deg.
alpha1=alpha1*pi/180;              
alpha2=alpha2*pi/180;

N=8;    %CCT������
I1 = 12000;             %CCT/Layer1, Current I1
I2 = -I1;               %CCT/Layer2, Current I2; Default I2=-I1

%-----------����ģ�͵���Ʋ���-------------
length=0.006;            %��Ȧ�����ĳ���(m)
width=0.004;             %��Ȧ�����Ŀ��(m)
ln=1;           %��Ȧ����泤�ȷ����ߵ�����
wn=1;         %��Ȧ������ȷ����ߵ�����

delta_w=width/2/wn;     %��Ȧ������ȷ��������߼�����һ��
delta_l=length/2/ln;    %��Ȧ����泤�ȷ��������߼�����һ��
I1=I1/ln/wn;            %����ģ��ÿ�����Ϸ�̯�ĵ���ֵ
I2=I2/ln/wn;

miu=4*pi*10^(-7);
total_steps = int32(2.0*pi*N/step);

%% Calculate Straight CCT Path, With Two Layers!
%Allocate Memory to Store CCT Sections

PathCenterVector_1_b = zeros(total_steps+1,3);
MultiLines_1 = zeros(total_steps+1,ln,wn,3);      % define array to contain multiple lines (ln*wn) in CCT path

PathCenterVector_2_b = zeros(total_steps+1,3);
MultiLines_2 = zeros(total_steps+1,ln,wn,3);      % define array to contain multiple lines (ln*wn) in CCT path


for theta=0:step:N*2*pi    %CCT���Ա���thetaϸ�ֵ�
    i=int32(theta/step)+1;
    PathCenterVector_1_b(i,:)=[-r1*cot(alpha1)*sin(theta).*cos(theta)-omega_i*sin(theta)/(2*pi)
        r1*cot(alpha1)*cos(theta).*cos(theta)+omega_i*cos(theta)/(2*pi)
        -r1];    %�ڲ���תCCT��i����ĸ�����ʸ��
    PathCenterVector_1_b(i,:) = PathCenterVector_1_b(i,:) / norm(PathCenterVector_1_b(i,:));
    for m=1:ln
        radius_1=r1-length/2+(2*m-1)*delta_l; %����ģ��ÿ�����ھ����ϵ�����
        for k=1:wn
            delta_p=(2*(k-wn/2)-1)*delta_w; %����ģ��ÿ�����ڸ������ϵ�����
            
            MultiLines_1(i,m,k,:)=[radius_1*cos(theta)+delta_p*PathCenterVector_1_b(i,1)
                radius_1*sin(theta)+delta_p*PathCenterVector_1_b(i,2)
                r1*cot(alpha1)*sin(theta)+omega_i*theta/2/pi+delta_p*PathCenterVector_1_b(i,3)];
        end
    end
end

figure(1)
for m=1:ln
    for k=1:wn
        plot3(MultiLines_1(:,m,k,1), MultiLines_1(:,m,k,2), MultiLines_1(:,m,k,3));
        hold on
    end
end

axis equal

for theta=0:step:N*2*pi
    i=int32(theta/step)+1;
    PathCenterVector_2_b(i,:)=[-r2*cot(alpha2)*sin(theta).*cos(theta)-omega_i*sin(theta)/(2*pi)
        r2*cot(alpha2)*cos(theta).*cos(theta)+omega_i*cos(theta)/(2*pi)
        -r2];    %�ڲ���תCCT��i����ĸ�����ʸ��
    PathCenterVector_2_b(i,:) = PathCenterVector_2_b(i,:) / norm(PathCenterVector_2_b(i,:));
    for m=1:ln
        radius_2=r2-length/2+(2*m-1)*delta_l; %����ģ��ÿ�����ھ����ϵ�����
        for k=1:wn
            delta_p=(2*(k-wn/2)-1)*delta_w; %����ģ��ÿ�����ڸ������ϵ�����
            
            MultiLines_2(i,m,k,:)=[radius_2*cos(theta)+delta_p*PathCenterVector_2_b(i,1)
                radius_2*sin(theta)+delta_p*PathCenterVector_2_b(i,2)
                r2*cot(alpha2)*sin(theta)+omega_i*theta/2/pi+delta_p*PathCenterVector_2_b(i,3)];
        end
    end
end

figure(1)
for m=1:ln
    for k=1:wn
        plot3(MultiLines_2(:,m,k,1), MultiLines_2(:,m,k,2), MultiLines_2(:,m,k,3));
        hold on
    end
end

axis equal



%% Calculate B Field of Straight CCT Path, With Two Layers!
%Allocate Memory to Store CCT Sections

%������ֱ�ߵ���ʼ���ս�㣺[x,y,z] unit:m
start_point = [0 0 -0.2];
end_point=[0 0 0.3];
%�ڵ����
point_num=51;       %�������ֱ���ϵĽڵ���Ŀ
CalcuPoint= [ linspace(start_point(1), end_point(1), point_num)'  linspace(start_point(2), end_point(2), point_num)' linspace(start_point(3), end_point(3), point_num)' ];

dB1 = zeros(total_steps+1,3);
sumdB1 = zeros(ln,wn,3);
B1 = zeros(point_num,3);

dB2 = zeros(total_steps+1,3);
sumdB2 = zeros(ln,wn,3);
B2 = zeros(point_num,3);

B_total = zeros(point_num,3);

for t=1:point_num
    for m=1:ln
        for k=1:wn
            for theta=step:step:N*2*pi %CCT���Ա���thetaϸ�ֵ�
                i=int32(theta/step);
                
                %% LAYER #1
                % Current_vector ���ô��ַ�ʽ��������� (i+1) - (i)�����ʸ��������ȫ== ��i�����ʸ��
                Current_vector = [MultiLines_1(i+1,m,k,1) - MultiLines_1(i,m,k,1)
                    MultiLines_1(i+1,m,k,2) - MultiLines_1(i,m,k,2)
                    MultiLines_1(i+1,m,k,3) - MultiLines_1(i,m,k,3)
                    ];
                
                Current_Center_Point = [MultiLines_1(i+1,m,k,1) + MultiLines_1(i,m,k,1)
                    MultiLines_1(i+1,m,k,2) + MultiLines_1(i,m,k,2)
                    MultiLines_1(i+1,m,k,3) + MultiLines_1(i,m,k,3)
                    ]/2.0;
                
                %disp(CalcuPoint(t , :)')
                CurrentToPoint_vector = CalcuPoint(t,:)' - Current_Center_Point;
                radial_vector_norm = norm(CurrentToPoint_vector);
                er=CurrentToPoint_vector / radial_vector_norm;
                multi=cross(Current_vector, er);
                dB1(i,:)=miu/4/pi*I1*multi/radial_vector_norm/radial_vector_norm; %Biot-Savart����ÿ��΢�ֵĴų�
            
              %% LAYER #2
                % Current_vector ���ô��ַ�ʽ��������� (i+1) - (i)�����ʸ��������ȫ== ��i�����ʸ��
                Current_vector = [MultiLines_2(i+1,m,k,1) - MultiLines_2(i,m,k,1)
                    MultiLines_2(i+1,m,k,2) - MultiLines_2(i,m,k,2)
                    MultiLines_2(i+1,m,k,3) - MultiLines_2(i,m,k,3)
                    ];
                
                Current_Center_Point = [MultiLines_2(i+1,m,k,1) + MultiLines_2(i,m,k,1)
                    MultiLines_2(i+1,m,k,2) + MultiLines_2(i,m,k,2)
                    MultiLines_2(i+1,m,k,3) + MultiLines_2(i,m,k,3)
                    ]/2.0;
                
                %disp(CalcuPoint(t , :)')
                CurrentToPoint_vector = CalcuPoint(t,:)' - Current_Center_Point;
                radial_vector_norm = norm(CurrentToPoint_vector);
                er=CurrentToPoint_vector / radial_vector_norm;
                multi=cross(Current_vector, er);
                dB2(i,:)=miu/4/pi*I2*multi/radial_vector_norm/radial_vector_norm; %Biot-Savart����ÿ��΢�ֵĴų�              
              
         
            end
            %disp('dB1: ')
            sumdB1(k,m,:)=sum(dB1,1);
            sumdB2(k,m,:)=sum(dB2,1);
        end
    end
    %disp('sumdB1: ')
    %disp(sumdB1)
    B1(t,:) = [sum(sum(sumdB1(:,:,1)))  sum(sum(sumdB1(:,:,2)))   sum(sum(sumdB1(:,:,3)))];
    B2(t,:) = [sum(sum(sumdB2(:,:,1)))  sum(sum(sumdB2(:,:,2)))   sum(sum(sumdB2(:,:,3)))];
    %B_total(t,:) =  B1(t,:) +  B2(t,:); 
    B_total(t,:) = [B1(t,1)+B2(t,1)  B1(t,2)+B2(t,2)   B1(t,3)+B2(t,3)];
    %B(t,:) = sum(sum(sumdB1));
end

disp(B_total)

figure(2)
hold on
line_length=end_point-start_point;
line_length=(line_length(1)^2+line_length(2)^2+line_length(3)^2)^0.5;
x_length=linspace(0,line_length,point_num);
line_Bx = plot(x_length,B_total(:,1),'-^g','LineWidth',1);
line_By = plot(x_length,B_total(:,2),'-xr','LineWidth',2);
line_Bz = plot(x_length,B_total(:,3),'--ob', 'LineWidth',2);

xlabel('s (m)','Fontname', 'Times New Roman','FontSize',18);
ylabel('B (T)','Fontname', 'Times New Roman','FontSize',18);
legend('Bx', 'By', 'Bz')
set(gca,'FontSize',13);
grid on



