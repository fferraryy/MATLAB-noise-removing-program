%% 3.4 
% design LP filter using FIR 
aLP = [1,1,0,0]; 
fLP = [0 0.12 0.22 1];
LLP = 100; 
hLP = firpm(LLP-1,fLP,aLP); 

% Design HP filter to remove other noise
aHP = [0 0 1 1]; 
fHP = [0 0.022 0.05 1]; 
LHP = 100; 
hHP = firpm(LHP-1,fHP,aHP);

% remove beep noise out by convolution 
mNorm1 = conv(sig_normds,hLP);
mNorm = conv(mNorm1,hHP); 
mAb1 = conv(sig_abds,hLP); 
mAb = conv(mAb1,hHP); 

% play sound 
sound(mNorm,fs)
pause 
sound(mAb,fs)
% save
audiowrite("NoisyNormal_filtered.wav.wav",mNorm,fs)
audiowrite("NoisyWheezy_filtered.wav.wav",mAb,fs)

%Plot freq domain
figure(12)
subplot(2,1,1)
freqplot(mNorm,fs)
ylabel("Magnitude")
title("frequency domain plot of filtered normal sound")
subplot(2,1,2)
freqplot(mAb,fs)
ylabel("Magnitude")
title("frequency domain plot of filtered whezzy sound")

%plot spectogram using window lenght = 500 samples 
figure(13)
subplot(2,1,1)
spectrogram(mNorm,500,5,[0:10:1200],fs,'yaxis'),colormap('jet')
title("Spectogram of filtered normal sound")
subplot(2,1,2)
spectrogram(mAb,500,5,[0:10:1200],fs,'yaxis'),colormap('jet')
title("Spectogram of filtered wheezy sound")

%Determine time range 
L_normdsft = length(mNorm); 
L_abdsft = length(mAb); 
Tds = 1/fs; 
t_normdsft = Tds:Tds:L_normdsft/fs; %define range of time for normal sound 
t_abdsft = Tds:Tds:L_abdsft/fs; %define range of time for abnormal(wheezy) sound\

%plot time domain 
figure(14)
subplot(2,1,1)
plot(t_normdsft,mNorm)
xlim([0 20])
title("Time domain plot of filtered normal sound")
xlabel("Time(s)")
ylabel("sound data")
subplot(2,1,2)
plot(t_abdsft,mAb)
xlabel("Time(s)")
ylabel("sound data")
title("Time domain plot of filtered wheezy sound")
xlim([0 20])
ylim([-0.5 0.5])
