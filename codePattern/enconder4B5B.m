function [t,y]=enconder4B5B(x,f0,fs,doPlot)
len=length(x)/4;
% source=[0,0,0,0;0,0,0,1;0,0,1,0;0,0,1,1;0,1,0,0;
%     0,1,0,1;0,1,1,0;0,1,1,1;1,0,0,0;
%     1,0,0,1;1,0,1,0;1,0,1,1;1,1,0,0;
%     1,1,0,1;1,1,1,0;1,1,1,1];
signal=[];
f0=f0*1000;
fs=fs*1000;  
t0=fix(fs/f0)*4/5;
t=0:1/fs:length(x)/f0;
t=t(1:length(t)-1);%��Ϊ��0��ʼ�����Զ���һ���㣬�Ѷ����һ����ص���
for i=1:1:len
    temp=x(4*(i-1)+1:4*(i-1)+4);
    num=temp(1)*8+temp(2)*4+temp(3)*2+temp(4);
    switch num
        case 0
            signal(1+(i-1)*5:5+(i-1)*5)=[1,1,1,1,0];
        case 1
            signal(1+(i-1)*5:5+(i-1)*5)=[0,1,0,0,1]; 
        case 2
            signal(1+(i-1)*5:5+(i-1)*5)=[1,0,1,0,0];    
        case 3
            signal(1+(i-1)*5:5+(i-1)*5)=[1,0,1,0,1];   
        case 4
            signal(1+(i-1)*5:5+(i-1)*5)=[0,1,0,1,0];   
        case 5
            signal(1+(i-1)*5:5+(i-1)*5)=[0,1,0,1,1]; 
        case 6
            signal(1+(i-1)*5:5+(i-1)*5)=[0,1,1,1,0];      
        case 7
            signal(1+(i-1)*5:5+(i-1)*5)=[0,1,1,1,1];       
        case 8
            signal(1+(i-1)*5:5+(i-1)*5)=[1,0,0,1,1];    
        case 9
            signal(1+(i-1)*5:5+(i-1)*5)=[1,0,0,1,1];  
        case 10
            signal(1+(i-1)*5:5+(i-1)*5)=[1,0,1,1,0];  
        case 11
            signal(1+(i-1)*5:5+(i-1)*5)=[1,0,1,1,1]; 
        case 12
            signal(1+(i-1)*5:5+(i-1)*5)=[1,1,0,1,0];  
        case 13
            signal(1+(i-1)*5:5+(i-1)*5)=[1,1,0,1,1]; 
        case 14
            signal(1+(i-1)*5:5+(i-1)*5)=[1,1,1,0,0];     
        case 15
            signal(1+(i-1)*5:5+(i-1)*5)=[1,1,1,0,1];            
    end
     signalTemp=signal;     
end
     for i=1:length(signalTemp)
       if(signalTemp(i) == 1)       %�����ϢΪ1

        for j = 1:t0    %����Ԫ��Ӧ�ĵ�ֵΪ1    

            y((i-1)*t0+j) = 1;

        end

    else

        for j = 1:t0    %��֮����ϢΪ0����Ԫ��Ӧ��ֵȡ0

            y((i-1)*t0+j) = 0;

        end

       end
     end
     
     
%�����׷���
%�趨NRZ����ʱ�䳤��Ϊ1s,��������Ϊ1500
if doPlot
nrzy=[ones(1,750),zeros(1,750)];
figure(1)
subplot(2,1,1)
nrzx=0:1/1500:1;
nrzx=nrzx(1:length(nrzx)-1);
plot(nrzx,nrzy);
xlabel('t/s')
ylabel('strength')
title('NRZʱ��')
fftY=fft(nrzy);
z=abs(fftY(1:750));
subplot(2,1,2)
plot(z)
xlabel('Ƶ��')
ylabel('strength')
title('NRZƵ��')
axis([0,50,0,500])
end
end
    
    