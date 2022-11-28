% Lab 2 for Digital Audio Signal Processing Lab Sessions
% Session 2: Binaural synthesis and 3D audio: OLA and WOLA frameworks
% R.Ali, G. Bernardi, J.Schott, A. Bertrand
% 2021
%
% The following is the skeleton code for the synthesis stage of the WOLA method, which you need to
% complete


function x = WOLA_synthesis(X,window,nfft,noverlap)
% WOLA_synthesis inverse short-time fourier transform.
%
% INPUT:
%   X           : input matrix (bins x frames x channels)
%   window      : window function
%   nfft        : FFT size
%   noverlap    : frame overlap; default: 2 (50%)
%
% OUTPUT:
%   x           : output time signal(s)


L = size(X, 2);
% Nombre des canaux
M = size(X, 3);

% ## Perform IFFT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section of code to complete (1 - 3 lines) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conjugaison compliquée pour signaux réels
X_full = [X(1:end-1, :, :); flipud(conj(X(2:end, :, :)))];

% ## Apply synthesis window

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section of code to complete (1 - 3 lines) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_ifft = ifft(X_full, nfft).*window;

% ## Obtain re-synthesised signals
x = zeros(L*nfft/noverlap+(nfft-nfft/noverlap), M);

for l = 0:L-1

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Section of code to complete (1 - 3 lines) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    start = l * (nfft / noverlap) + 1;
    fin = start + nfft - 1;
    % Reconstruire le signal d'origine
    x(start:fin, :) = x(start:fin, :) + squeeze(x_ifft(:, l+1, :));
end

end
