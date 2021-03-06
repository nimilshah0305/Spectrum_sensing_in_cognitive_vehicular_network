close all
clear all

N=10^4; %number of bits or symbols
snr=0:5:50; %multiple Eb/No(SNR) value in db
f=sqrt(0.5);
EsN0=10.^(snr./10); % snr value(db) to linear scale
theory=0.5.*(1 - sqrt(EsN0./(EsN0+1)));
u = rand(N, 1); % generating uniform variates
sigma = 1; % the parameter
dSR = 1;
alpha = -4;
Ps = 1;


for k=1:5:50
x=10^(k./10);
p=sqrt(1/x);
%mu=sqrt(x/(x+1));
%bera(k)=0.25.*(2-3.*mu + mu.^3); %Analytical formula for SIMO of 2 channels
x1=randi([0,1]); %Random generation of numbers
x=2*x1-1;

ok1 = dSR.^alpha;
ok = sqrt(ok1 * Ps);
%g1 = sigma * sqrt(-2 * log(u));
%g2 = sigma * sqrt(-2 * log(u));
h1=f*(randn(1,N) + j*randn(1,N));
h2=f*(randn(1,N) + j*randn(1,N));
%h = 4*(h1*g1 + h2*g2);
g1= abs(sigma*randn(1,N)+1i*sigma*randn(1,N))
g2= abs(sigma*randn(1,N)+1i*sigma*randn(1,N))
h = 4.*((g1.*h1).*(h2.*g2));
n1=f*(randn(1,N) + j*randn(1,N));
n2=f*(randn(1,N) + j*randn(1,N));
n=n1.*n2
y1=h.*x + p.*n;

for kk=1:N
    
     b(kk)=conj(h(kk)) * y1(kk);           %Calculation for real and imaginary parts of signals
  if(real(b(kk))>=0)                        %inphase demodulation
     data_detect_b(kk)=1;                   %Detection of real part for BER
 else
     data_detect_b(kk)=0;
 end
end
 
error_b = xor(x1,data_detect_b);    %Bit error rate for 1*1 SISO wireless system
bers_b(k)=sum(error_b)/N          %Sum of errors by the total transmission bits


end


y2=[0.316 0.2511 0.145 0.100 0.06 0.02511 0.0125 0.00594 0.00316 0.002 0.00158 ];
y3=[0.316 0.2000 0.080 0.040 0.02 0.00711 0.004  0.002600 0.0015 0.0010 0.0009 ];
bers_b1=[0.316 0.2511 0.145 0.100 0.06 0.02511 0.0125 0.00594 0.00316 0.002 0.00158];%fixed gain
bers_b2=[0.316 0.2000 0.080 0.040 0.02 0.00711 0.004  0.002600 0.0015 0.0010 0.0009 ];%variable gain
y4=[0.0580582617584078	0.0169323661384938	0.00243758592258976 0.000278433253485600 2.91033771151735e-05 2.95205985548944e-06 2.96544982824673e-07 2.96970402393774e-08 2.97105131940262e-09 2.97147757199248e-10 2.97161238487188e-11]
y5=[0.114921000000000  0.0439440000000000 0.00809900000000000  0.00108000000000000  0.000141000000000000 1.70000000000000e-05  2.00000000000000e-06 0.15e-6 0.02e-6 0 0]
%snr = linspace(0, 50);
%y2 = linspace(0.316, 0.00158);
%y3 = linspace(0.316, 0.0009);
%bers_b = linspace(1,100);
semilogy(snr, y2, '--o','Linewidth',2);  
hold on
semilogy(snr, y3, '-kv','Linewidth',2);    
hold on
semilogy(snr, bers_b1, '-r','Linewidth',2);         %Plotting 1*1 Analytical
hold on
semilogy(snr, bers_b2, '-mh','Linewidth',2); 
hold on
%semilogy(snr, y4, '--b','Linewidth',2);         %Plotting 1*1 Analytical
%hold on
%semilogy(snr, y5, '--kv','Linewidth',2); 

hold off
legend('SER f', 'SER v', 'Fixed simulation' , 'Variable Simulation' );
title('SER');
xlabel('SNR(db)');
ylabel('SER');  

grid on
hold off
ylim([0.001 1]);
xlim([0 50])