%% ��ʼ��
clear all
f0=1;
fs=10;
SNR=5;
doPlot=true;
signalFinal=[];
bitError=[];
errorNum=0;
%���ض����Ʒ���
x=load('signalSource');
s=x.s;
num=20000;
i=0;
x1=s(1:20000);
   %% ��·��ӳ��
    %Ƶ�ʵ�λΪK
    [t,y]=HDB3(x1,1,10,doPlot);
    [clockx,clocky]=Myclock(f0,fs);
    figure(2)
    plot(clockx,clocky+2)
    hold on
    plot(t,y)
    axis([5.28,5.29,-1.5,3.5]);
    legend('clock','data');
    ylabel('strength')
    xlabel('t/s')
    title('��·���ź�')
    %% ������
    [Pxx,f]=periodogram(abs(y),[],[],fs*1000); %ֱ�ӷ�
    figure(3)
    plot(f,10*log10(Pxx));
    ylabel('strength/db')
    xlabel('f/HZ')
    title('HDB3�źŹ�����')
    
    %% �ŵ�����
    signalAWGN=awgn(y,SNR,'measured');
    figure(4)
    subplot(2,1,1)
    plot(t,signalAWGN)
    axis([5.28,5.29,-1.5,2]);

    %% ��Դ����
    T=1/f0;
    st=ones(1,10);
    numZeros=0;
    signalGet=conv(signalAWGN,st)/10;
    figure(4)
    subplot(2,1,2)
    stem(t,signalGet(1:length(t)))
    axis([0,0.01,-1,2]);
    signalSample=signalGet(10:10:end);
    signalTemp=signalSample;
    signalTemp(signalTemp<-0.5)=-1;
    signalTemp(signalTemp>0.5)=1;
    signalTemp=fix(signalTemp);
    input=signalTemp;                   % HDB3������
    decode=input;               % �����ʼ��
    sign=0;                     % ���Ա�־��ʼ��
    for k=1:length(signalTemp)
        if input(k) ~= 0
           if (sign==signalTemp(k)&&(numZeros>1)) % �����ǰ����ǰһ��������ļ�����ͬ����ֹ����ش��������д���
              decode(k-3:k)=[0 0 0 0];% �������ΪV�벢��*00V����
           end
           sign=input(k);       % ���Ա�־
           numZeros=0;          %��־��0
        else
            numZeros=numZeros+1;

        end
    end
    signalAbs=abs(decode);
    signalJugdgment=bitxor(signalAbs,x1);
    signalError=find(signalJugdgment);
    bitError=vertcat(bitError,length(signalError)/num);
    %% ����
    signalNonzeroy=find(decode);
    signalErrorCorrection=decode(signalNonzeroy);
    for i=2:2:length(signalErrorCorrection)
        if(signalErrorCorrection(i)~=-signalErrorCorrection(i-1))
            signalErrorCorrection(i)=-signalErrorCorrection(i-1);
            errorNum=errorNum+1;
        end
    end
            
            
        
    
    
    
    
