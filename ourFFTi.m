% INVERSE FFT
% IT IS A WRAPPER FOR ourFFT(...)
function [x]=ourFFTi(X)

x=ourFFT(X,'backward');