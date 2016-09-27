fm = 200;
fc = 1000;
fs = 10000;
t=0:1/fs:(2/fm-1/fs);
signal = 0.5*sin(2*pi*fm*t);
modulated_signal = modulate(signal,fc,fs,'PPM');
demodulated_signal = demod(modulated_signal,fc,fs,'PPM');
figure
subplot(3,1,1);
plot(signal);
subplot(3,1,2);
plot(modulated_signal);
subplot(3,1,3);
plot(demodulated_signal);