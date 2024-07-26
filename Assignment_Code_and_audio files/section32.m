%% 3.2 
% import signal
[sig_norm, Fs] = audioread("NoisyNormal.wav"); 
[sig_ab, Fs] = audioread("NoisyWheezy.wav"); 

% factor = 5 
L = 5; 

%anti-aliasing 
fs = Fs/L; 
wc = 2*pi*fs/2; 
[a,b] = butter(10,0.2,'low'); 
sig_norm = filter(a,b,sig_norm);
sig_ab = filter(a,b,sig_ab);

% downsampling signals
sig_abds = sig_ab(1:L:end); 
sig_normds = sig_norm(1:L:end); 

%play  soubd 
sound(sig_normds,Fs/L) 
pause 
sound(sig_abds,Fs/L)

%save
audiowrite("NoisyNormal_downsampled.wav.wav",sig_normds,fs)
audiowrite("NoisyWheezy_downsampled.wav.wav",sig_abds,fs)

% determine fft fot the plot
X_normds = fft(sig_normds); 
X_abds = fft(sig_abds); 
Nnormds = length(sig_normds); 
Nabds = length(sig_abds); 
omegaNormds = (-floor(Nnormds/2):(Nnormds-1-floor(Nnormds/2)))*(fs/Nnormds); 
omegaAbds = (-floor(Nabds/2):(Nabds-1-floor(Nabds/2)))*(fs/Nabds); 

%plot frequency domain 
figure(3)
subplot(2,1,1)
plot(omegaNormds,fftshift(abs(X_normds)))
xlabel("frequency (Hz) ")
ylabel("magnitude")
title("Frequency domain plot of Normal sound")
subplot(2,1,2)
plot(omegaAbds,fftshift(abs(X_abds)))
title("Frequency domain plot of Whezzy sound")
xlabel("frequency (Hz) ")
ylabel("magnitude")
ylim([0 6000])

%determine samples 
%1-7 
intOneds = (7-1)*fs; 
%9-11
intTwods = (11-9)*fs; 
%17-19
intThreeds = (19-17)*fs; 
