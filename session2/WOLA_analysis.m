% Lab 2 for Digital Audio Signal Processing Lab Sessions
% Session 2: Binaural synthesis and 3D audio: OLA and WOLA frameworks
% R.Ali, G. Bernardi, J.Schott, A. Bertrand
% 2021
%
% The following is the skeleton code for the analysis stage of the WOLA method, which you need to
% complete


function [X,f] = WOLA_analysis(x,fs,window,nfft,noverlap, g)
%WOLA_analysis  short-time fourier transform
% INPUT:
%   x           : input time signal(s) (samples x channels)
%   fs          : sampling rate
%   window      : window function
%   nfft        : FFT size
%   noverlap    : frame overlap; default: 2 (50%)
%   g           : filter
%
% OUTPUT:
%   X           : STFT matrix (bins x frames x channels)
%   f           : frequency vector for bins


% use only half FFT spectrum
N_half = nfft / 2 + 1;

% get frequency vector
f = 0:(fs / 2) / (N_half - 1):fs / 2;

% init
L = floor((length(x) - nfft + (nfft / noverlap)) / (nfft / noverlap)); % nombre de trames des STFT
M = size(x,2); % Nombre de canaux de signal
X = zeros(N_half, L, M); % Résultat de STFT

G = fft(g, nfft);

for m = 0:M-1
    for l = 0:L-1 % Frame index

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Section of code to complete (3 - 5 lines) %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        start = l * (nfft - nfft / noverlap) + 1;
        fin = start + nfft - 1;
        % Appliquer le fenetrage au le signal
        x_win = x(start:fin, m+1) .* window;
        X_win = fft(x_win, nfft);
        X_win_filt = X_win .* G(:, m+1);
        X(:, l+1, m+1) = X_win_filt(1:N_half);
    end
end

end
