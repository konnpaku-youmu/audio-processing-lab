close all
clear
clc

load filtre_Hg
g = reshape(g, [], 5);

fs_new = 8000;
mic_length = 10;
L = mic_length * fs_new;

[speech1,fs] = audioread('../audio files/speech1.wav');
speech1      = resample(speech1, fs_new, fs);
speech1 = speech1(1:L);

%% Dirac réponse impulsionnelle
nfft = 4096;

h = zeros(100, 1);
h(1) = 1;

y = OLA(speech1, h, nfft);

% plot(y);

%% Tester sur HRTF
g = g(:);
hrtf = reshape(H*g, [], 2);

% Synthèse par convolution
tic;
speech_conv_l = conv(speech1, hrtf(:, 1), 'same');
speech_conv_r = conv(speech1, hrtf(:, 2), 'same');
toc;
speech_conv_bin = [speech_conv_l, speech_conv_r];

% Synthèse par OLA
tic;
speech_ola_l = OLA(speech1, hrtf(:, 1), nfft);
speech_ola_r = OLA(speech1, hrtf(:, 2), nfft);
toc;
speech_ola_bin = [speech_ola_l, speech_ola_r];

% % écouter les signals
% soundsc(speech_ola_bin, fs_new); pause;
% soundsc(speech_conv_bin, fs_new);

%% WOLA
speech1_multichan = repmat(speech1, 1, 5);
window = hamming(nfft);
[X, f] = WOLA_analysis(speech1_multichan, fs_new, window, nfft, 2);

x = WOLA_synthesis(X, window, nfft, 2);
