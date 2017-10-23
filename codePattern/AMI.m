function [t,y] = AMI(x,f0,fs,doPlot)

%������ʵ�ֽ������һ�ζ����ƴ����Ϊ��Ӧ��AMI�����

%����xΪ�������룬���yΪ����ĵ����Էǹ�����

%f0�����ʣ�fs�ǲ����ʣ����������������λK
num=1;
f0=f0*1000;
fs=fs*1000;  
t0=fix(fs/f0);
t=0:1/fs:length(x)/f0;
t=t(1:length(t)-1);%��Ϊ��0��ʼ�����Զ���һ���㣬�Ѷ����һ����ص���
for i = 1:length(x)     %������Ԫ��ֵ

    if(x(i) == 1)       %�����ϢΪ1 
            if(mod(num,2)==1)
                 for j = 1:t0/2    %����Ԫ��Ӧ�ĵ�ֵΪ1   
                     y((i-1)*t0+j) = 1;
                 end
                 for j = t0/2+1:t0    %����Ԫ��Ӧ�ĵ�ֵΪ1   
                     y((i-1)*t0+j) = 0;  
                 end
            elseif(mod(num,2)==0)
                 for j = 1:t0/2    %����Ԫ��Ӧ�ĵ�ֵΪ1   
                     y((i-1)*t0+j) = -1;
                 end
                 for j = t0/2+1:t0    %����Ԫ��Ӧ�ĵ�ֵΪ1   
                     y((i-1)*t0+j) = 0;  
                 end
            else
                 y((i-1)*t0+j) = -2;
            end
         num=num+1;

    else

        for j = 1:t0    %��֮����ϢΪ0����Ԫ��Ӧ��ֵȡ0

            y((i-1)*t0+j) = 0;

        end

    end
    

end

%�����׷���
%�趨NRZ����ʱ�䳤��Ϊ1s,��������Ϊ1500
if doPlot
nrzy=[ones(1,1500)];
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
