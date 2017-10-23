%% ��ʼ��
%�͵�ƽ��ʾ0���ߵ͵�ƽ�����ʾ1.
clear all
f0=1;
fs=10;
SNR=5;
num=200000;
doPlot=true;
signalFinal=[];
bitError=[];
errorNum=0;
%���ض����Ʒ���
x=load('signalSource');
s=x.s;
i=0;
x1=s(1:100000);
   %% ��·��ӳ��
    %Ƶ�ʵ�λΪK
    [t,y]=AMI(x1,1,10,doPlot);
    [clockx,clocky]=Myclock(f0,fs);
    figure(2)
    plot(clockx(1:200),clocky(1:200)+2)
    hold on
    plot(t(1:100),y(1:100))
    axis([0,0.01,-1.5,3.5]);
    legend('clock','data');
    ylabel('strength')
    xlabel('t/s')
    title('��·���ź�')
    %% ������
    %Ҳ���ǹ������⣬��Ҫ���ʽϵ�
    [Pxx,f]=periodogram(y,[],[],fs*1000); %ֱ�ӷ�
    figure(3)
    plot(f,10*log10(Pxx));
    ylabel('strength/db')
    xlabel('f/HZ')
    title('AMI�źŹ�����')
    
    %% �ŵ�����
    signalAWGN=awgn(y,SNR,'measured');
    figure(4)
    subplot(2,1,1)
    plot(t(1:100),signalAWGN(1:100))
    axis([0,0.01,-1.5,2]);

    %% ��Դ����
    T=1/f0;
    st=ones(1,5);
    signalGet=conv(signalAWGN,st)/5;
    figure(4)
    subplot(2,1,2)
    stem(t(1:100),signalGet(1:100))
    axis([0,0.01,-1,2]);
    signalSmy=signalGet;
    signalSmy(signalSmy<0.5)=-1;
    signalSmy(signalSmy<0.5)=1;
    signalSmy=fix(signalSmy);
    signalSample=signalGet(5:10:end);
    signalTemp=signalSample;
    signalTemp(signalTemp<-0.5)=-1;
    signalTemp(signalTemp>0.5)=1;
    signalTemp=fix(signalTemp);
    signalAbs=abs(signalTemp);
    %���պ�����
    [Pxx,f]=periodogram(abs(signalSmy),[],[],fs*1000); %ֱ�ӷ�
    figure(5)
    plot(f,10*log10(Pxx));
    ylabel('strength/db')
    xlabel('f/HZ')
    title('AMI�źŹ�����')
    signalJugdgment=bitxor(signalAbs,x1);
    signalError=find(signalJugdgment);
    bitError=vertcat(bitError,length(signalError)/num);
    %% ���
    %�������1�ķ�����ͬ����ô�϶���һ�������ˡ�
    %һ��1�����-1������һ��-1�����1������0�����1��-1.
    signalNonzeroYlabel=find(signalTemp);
    signalErrorCorrection=signalTemp(signalNonzeroYlabel);
    for i=2:2:length(signalErrorCorrection)
        if(signalErrorCorrection(i)~=-signalErrorCorrection(i-1))
%           signalErrorCorrection(i)=-signalErrorCorrection(i-1);
            errorNum=errorNum+1;
        end
    end
            
            
        
    
    
    
    
