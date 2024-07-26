%% 3.1 
% import signal
[sig_norm, Fs] = audioread("NoisyNormal.wav"); 
[sig_ab, Fs] = audioread("NoisyWheezy.wav"); 
L_norm = length(sig_norm); 
L_ab = length(sig_ab); 

%play sound 
sound(sig_norm,Fs)
pause
sound(sig_ab,Fs)

% determine total time range of each signal 
Ttot_norm = L_norm/Fs; 
Ttot_ab = L_ab/Fs; 
T0 = 1/Fs; %period
t_norm = T0:T0:Ttot_norm; %define range of time for normal sound 
t_ab = T0:T0:Ttot_ab; %define range of time for abnormal(wheezy) sound 
%determine fourier coefficients
X_norm = (1/L_norm)*fft(sig_norm); 
X_ab = (1/L_ab)*fft(sig_ab); 
%determine omega range
omega_norm = (-floor(L_norm/2):(L_norm-1-floor(L_norm/2)))*(Fs/L_norm);
omega_ab = (-floor(L_ab/2):(L_ab-1-floor(L_ab/2)))*(Fs/L_ab);

%plot time doamin 
figure(1)
subplot(2,1,1)
plot(t_norm,sig_norm)
title("Time Domain Plot of Normal sound")
xlabel("time(s)")
ylabel("sound data")
xlim([0 20]) 
subplot(2,1,2)
plot(t_ab,sig_ab)
title("Time Domain Plot of Wheezy sound")
xlabel("time(s)")
ylabel("sound data")
xlim([0 20]) 

%plot frequency domain 
figure(2)
subplot(2,1,1)
plot(omega_norm,fftshift(abs(X_norm)))
title("Frequency Domain Plot of Normal sound")
xlabel('k')
ylabel("magnitude")
subplot(2,1,2)
plot(omega_ab,fftshift(abs(X_ab)))
title("Frequency Domain Plot of Wheezy sound")
xlabel('k')
ylabel("magnitude")
ylim([0 0.03])

%determine samples 
%1-7s 
intOne = (7-1)*Fs; 
%9-11
intTwo = (11-9)*Fs;
%14-18s 
intThree = (18-14)*Fs;


