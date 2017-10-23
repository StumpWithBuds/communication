function [t,y] = HDB3(x,f0,fs,doPlot)

%������ʵ�ֽ������һ�ζ����ƴ����Ϊ��Ӧ��AMI�����

%����xΪ�������룬���yΪ����ĵ����Էǹ�����

%f0�����ʣ�fs�ǲ����ʣ����������������λK
x=HDB3trans(x);%���б���ת��
f0=f0*1000;
fs=fs*1000;  
t0=fix(fs/f0);
t=0:1/fs:length(x)/f0;
t=t(1:length(t)-1);%��Ϊ��0��ʼ�����Զ���һ���㣬�Ѷ����һ����ص���
for i = 1:length(x)     %������Ԫ��ֵ
    if(x(i)==1);
       for j = 1:t0    %����Ԫ��Ӧ�ĵ�ֵΪ1    
           y((i-1)*t0+j) = 1;
       end
    elseif(x(i)==-1)
       for j = 1:t0    %����Ԫ��Ӧ�ĵ�ֵΪ1    
           y((i-1)*t0+j) = -1;
       end
    else
      for j = 1:t0    %����Ԫ��Ӧ�ĵ�ֵΪ1    
          y((i-1)*t0+j) =0;
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

function y=HDB3trans(x)
xn=x;
yn=xn;% ���yn��ʼ��
numZerosContiuns=0;% ��������ʼ��
for k=1:length(xn)
   if xn(k)==1
      numZerosContiuns=numZerosContiuns+1;                % "1"������
         if numZerosContiuns/2 == fix(numZerosContiuns/2) % ������1ʱ���-1,���м��Խ���
              yn(k)=1;
         else
              yn(k)=-1;
         end
    end
end
        % HDB3����
numZerosContiuns=0;  % �����������ʼ��
yh=yn;  % �����ʼ��
sign=0; % ���Ա�־��ʼ��Ϊ0
V=zeros(1,length(yn));% V����λ�ü�¼���� 
B=zeros(1,length(yn));% B����λ�ü�¼����
for k=1:length(yn)
   if yn(k)==0
       numZerosContiuns=numZerosContiuns+1;  % ����0����������
       if numZerosContiuns==4   % ���4����0��
           numZerosContiuns=0;    % ����������
           if(k==4)%��ʼ4��ֵΪ0
               yh(1)=1;
               yh(4)=1;
               sign=1;
          else
         yh(k)=1*yh(k-4); 
                            % ��0000�����һ��0�ı�Ϊ��ǰһ�����������ͬ���Եķ���
         V(k)=yh(k);        % V����λ�ü�¼
         if yh(k)==sign     % �����ǰV������ǰһ��V���ŵļ�����ͬ
            yh(k)=-1*yh(k); % ���õ�ǰV���ż��Է�ת,������V���ż��໥���Է�תҪ��
            yh(k-3)=yh(k);  % ���B����,��V����ͬ����
            B(k-3)=yh(k);   % B����λ�ü�¼
            V(k)=yh(k);     % V����λ�ü�¼
            yh(k+1:length(yn))=-1*yh(k+1:length(yn));
                            % ���ú���ķ�����Ŵ�V���ſ�ʼ�ٽ���仯
         end
           end
       end
       sign=yh(k);          % ��¼ǰһ��V���ŵļ���
  else
      numZerosContiuns=0;                % ��ǰ����Ϊ��1��������0������������
  end
end    
y=yh;
end