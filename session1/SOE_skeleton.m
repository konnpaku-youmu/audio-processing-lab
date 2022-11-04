% Lab 1 for Digital Audio Signal Processing Lab Sessions
% Exercise 1-4: 3D audio
% 
% In this lab, we derive a set of filters g that can be used, along with
% the measured RIRs H, to produce the proper psychocoustic rendition of 3D
% audio
%

clear;
% close all

% Load ATFs
load Computed_RIRs

% Load measured HRTFs
load HRTF

% Define the signal length
siglength = 10;

% Load the speech signal and resample
speechfilename = 'audio files/speech1.wav';
[speech, fs_audio] = audioread(speechfilename);
speech = resample(speech, fs_RIR, fs_audio);
L = siglength * fs_RIR;
speech = speech(1:L);

% Noise flag for the noise perturbing SOE
noiseFlag = 0;
% Noise flag for sweetspot tests
sweetspotFlag = 0;

% Number of loudspeakers
J = size(RIR_sources,3);

% Define the lengths of RIRs and g filters
Lh = 600; % Length of impulse responses of listeniLg room
Lg = 400; % Length of filters g_j

% Truncate impulse response to reduce computational complexity
RIR_sources = RIR_sources(1:Lh, :, :);

% Calculate delay for SOE
delta = ceil(sqrt((m_pos(2, 1) - s_pos(2, 1))^2+(m_pos(2, 2) - s_pos(2, 2))^2)*fs_RIR/340);

% Define the Toeplitz matrices for left and right ear (left side of SOE)
HL=[];
HR=[];

hl = squeeze(RIR_sources(:, 1, :));
hr = squeeze(RIR_sources(:, 2, :));

hcol = [hl; zeros(Lg-1, J)];
hrow = [hl(1, :); zeros(Lg-1, J)]';

for j=1:J
    H_JL = toeplitz(hcol(:, j), hrow(j, :));
    HL(:, ((j-1)*Lg)+1:j*Lg) = H_JL;
end

hcol = [hr; zeros(Lg-1, J)];
hrow = [hr(1, :); zeros(Lg-1, J)]';

for j=1:J
    H_JR = toeplitz(hcol(:, j), hrow(j, :));
    HR(:, ((j-1)*Lg)+1:j*Lg) = H_JR;
end

% Define the HRTFs for left and right ear (right side of SOE) from the 
% loaded HRTF
% xL = zeros(Lh+Lg-1, 1); % Left ear
% xL(1) = 1;
% xR = zeros(Lh+Lg-1, 1); % Right ear
% xR(1) = 1;

xL = HRTF(1:Lh+Lg-1, 1);
xR = HRTF(1:Lh+Lg-1, 2);

xL = delayseq(xL, delta);
xR = delayseq(xR, delta);

% Construct H (from HL and HR) and x (from xL and xR) and remove all-zero rows in H, 
% and the corresponding elements in x
H = [HL(delta+1:end, :); HR(delta+1:end, :)];
x = [xL(delta+1:end); xR(delta+1:end)];

% Solve the SOE
if ~noiseFlag
    % Without noise
    g = H\x;
else
    % With noise
end

% % Plot estimated and real HRTFs
% figure(1);
% clf;

% Calculate synthesis error
synthErr = norm(H*g-x);
disp(synthErr);

% Synthethize the binaural speech using H and g and compare it 
% (psychoacoustically) to the binaural speech synthetized with x
g = reshape(g, [Lg, J]);
speech_synth = fftfilt(g, speech);
mic1 = sum(fftfilt(hl, speech_synth), 2);
mic2 = sum(fftfilt(hr, speech_synth), 2);

soundsc([mic1, mic2]);

