[u, Fs]=audioread('mike.wav'); %read mike

yy=[zeros(0.1*Fs,1);u];     %delay mike 100ms by putting zeros
u=[u;zeros(0.1*Fs,1)];      
x=yy+u;                     %add mike and delayed mike
nx=length(x);
sx=size(x);

zzz=zeros(1,11);
%N and K constant alpha takes values 0,0.1,0.2,0.3...1

for m=0:10
  t1=0;
  t2=0;  
  y=n_tap_filter(6,(m*0.1),0.1,nx,sx,x,Fs);

%calculate snr for each different alpha   
  for p=1:length(u)
    t1=t1+u(p)*u(p);
    t2=t2+(y(p)-u(p))*(y(p)-u(p));
  end
zzz(m+1)=10*log10(t1/t2);
end

%plot
ttt=0:10;
figure;
plot(ttt,zzz(ttt+1));
xlabel('alpha*10');
ylabel('SNR');

zz=zeros(1,4);
%N and alpha constant K takes values 100,200,300,400 ms
for m=1:4
  t1=0;
  t2=0;  
  y=n_tap_filter(6,0.5,(m*0.1),nx,sx,x,Fs);
%calculate snr value for each different K  
  for p=1:length(u)
    t1=t1+u(p)*u(p);
    t2=t2+(y(p)-u(p))*(y(p)-u(p));
  end
zz(m)=10*log10(t1/t2);
end
%plot
tt=1:4;
figure;
plot(tt,zz(tt));
xlabel('K(decisecond)');
ylabel('SNR');

z=zeros(1,50);
%K and alpha constant N take values from 1 to 50
for k=1:50   
t1=0;
t2=0;
y=n_tap_filter(k,0.5,0.1,nx,sx,x,Fs);
%calculate snr value for each different N
for m=1:length(u)
    t1=t1+u(m)*u(m);
    t2=t2+(y(m)-u(m))*(y(m)-u(m));
end
z(k)=10*log10(t1/t2);
end
%plot
t=1:50;
figure;
plot(t,z(t));
xlabel('N');
ylabel('SNR');