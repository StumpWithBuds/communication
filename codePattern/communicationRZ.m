 %% ��ʼ��
 %�ߵ�ƽ��ʾ1���͵�ƽ��ʾ0����һ��ʱ�������ڻ��0.
clear all
f0=1;
fs=10;
SNR=5;
signalFinal=[];
bitError=[];
doPlot=true;
%���ض����Ʒ���
x=load('signalSource');
s=x.s;
num=length(s);
i=0;
x1=s(1:10000);
   %% ��·��ӳ��
    %Ƶ�ʵ�λΪK
    [t,y]=srz(x1,1,10,doPlot);
    [clockx,clocky]=Myclock(f0,fs);
    figure(2)
    plot(clockx(1:200),clocky(1:200)+2)
    hold on
    plot(t(1:100),y(1:100))
    axis([0,0.01,-1,4]);
    legend('clock','data');
    ylabel('strength')
    xlabel('t/s')
    title('��·���ź�')
    %% ������
    [Pxx,f]=periodogram(y,[],[],fs*1000); %ֱ�ӷ�
    figure(3)
    plot(f,10*log10(Pxx));
    ylabel('strength/db')
    xlabel('f/HZ')
    title('RZ�źŹ�����')
    
    %% �ŵ�����
    signalAWGN=awgn(y,SNR,'measured');
    figure(4)
    subplot(2,1,1)
    plot(t(1:100),signalAWGN(1:100))
    axis([0,0.01,-1,2]);

    %% ��Դ����
    T=1/f0;
    st=ones(1,5);
    %�����Եļ�С�������ھ�ֵ�����ļ�С��
    signalGet=conv(signalAWGN,st)/5;%���ݹ�0ʱ�̶�
    figure(4)
    subplot(2,1,2)
    stem(t(1:100),signalGet(1:100))
    axis([0,0.01,-1,2]);
    signalSample=signalGet(5:10:end-5);%����������䣬���ǳ�����ʼ��ı��ˡ�
    signalTemp=signalSample;
    signalTemp(signalTemp<0.5)=0;
    signalTemp(signalTemp>0.5)=1;
    signalJugdgment=bitxor(signalTemp,x1);
    signalFinal=
    signalError=find(signalJugdgment);
bitError=vertcat(bitError,length(signalError)/num);
