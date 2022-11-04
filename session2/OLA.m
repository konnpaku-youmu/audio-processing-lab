% Lab 2 for Digital Audio Signal Processing Lab Sessions
% Session 2: Binaural synthesis and 3D audio: OLA and WOLA frameworks
% R.Ali, G. Bernardi, J.Schott, A. Bertrand
% 2021
%
% The following is the skeleton code for the OLA function, which you need to
% complete.

function y = OLA(x,h,nfft)
%
% Overlap and add method for computing convolution between the filter, h,
% and signal x.
% INPUT:
%   x           : input time-domain signal(s) (samples x 1)
%   h           : filter (samples x 1)
%   nfft        : FFT size
%
% OUTPUT:
%   y           : convolved output signal

narginchk(2,3)

Lh = length(h);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section of code to complete (1-2) lines %
% Calculate the appropriate value of Lx, the frame length of x,
% given your nfft and Lh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


H = fft(h, nfft);   % DFT of h
H = H(:);           % make into a column vector (speed)
nx = length(x);     % total length of x

Lx = nfft - (Lh - 1);
y = zeros(ceil(nx/Lx)*nfft,1);

istart = 1;
while istart <= nx

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Section of code to complete (5 - 10 lines) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(istart+Lx-1 < nx)
        eind_x = istart+Lx-1;
    else
        eind_x = nx;
    end
    y(istart:istart+nfft-1) = y(istart:istart+nfft-1) + ifft(fft(x(istart:eind_x), nfft).*H, nfft);
    istart = istart + Lx;
end

end
