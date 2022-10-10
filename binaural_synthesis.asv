close all
clear
clc

load("HRTF.mat");

fs_new = 8000;
mic_length = 10;
L = mic_length * fs_new;

[speech1,fs] = audioread('audio files/speech1.wav');
speech1      = resample(speech1, fs_new, fs);
x1 = speech1(1:L);

[speech2,fs] = audioread('audio files/speech2.wav');
speech2      = resample(speech2, fs_new, fs);
x2 = speech2(1:L);

[bin_sig1_1, bin_sig2_1, bin_sig3_1, bin_sig4_1] = generate_binaural(x1, HRTF);
[bin_sig1_2, bin_sig2_2, bin_sig3_2, bin_sig4_2] = generate_binaural(x1, HRTF);

bin_sig1 = bin_sig1_1 + bin_sig1_2;
bin_sig2 = bin_sig2_1 + bin_sig2_2;
bin_sig3 = bin_sig3_1 + bin_sig3_2;
bin_sig4 = bin_sig4_1 + bin_sig4_2;

function [sig1, sig2, sig3, sig4] = generate_binaural(sig_org, hrtf)
    sig1 = [sig_org, sig_org];
    sig2 = [sig_org, 0.5 * sig_org];
    sig3 = [sig_org, delayseq(sig_org, 3)];
    sig4 = [fftfilt(hrtf(:, 1), sig_org), fftfilt(hrtf(:, 2), sig_org)];
end