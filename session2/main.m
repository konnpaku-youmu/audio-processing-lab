close all
clear
clc

fs_new = 8000;
mic_length = 2;
L = mic_length * fs_new;

[speech1,fs] = audioread('../audio files/speech1.wav');
speech1      = resample(speech1, fs_new, fs);
x1 = speech1(1:L);

% [speech2,fs] = audioread('../audio files/speech2.wav');
% speech2      = resample(speech2, fs_new, fs);
% x2 = speech2(1:L);

h = [1, zeros(1, 99)];
nfft = 2048;




