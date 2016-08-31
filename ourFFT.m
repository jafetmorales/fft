% FAST FOURIER TRANSFORM IMPLEMENTATION
% THE FIRST ARGUMENT IS THE INPUT SEQUENCE
% THE SECOND ARGUMENT IS OPTIONAL AND IT SHOULD BE EITHER 'FORWARD'
% FOR FORWARD TRANSFORM OR 'BACKWARD' FOR INVERSE FFT
% BY JAFET MORALES
function [X]=ourFFT(x,varargin)

back=0;
if(length(varargin)==1)
    if(strcmp(varargin{1},'backward'))
        back=1;
    elseif(strcmp(varargin{1},'forward'))
        back=0;
    else
        error('second argument must to be either forward or backward')
    end
end
if(back==0)
    disp('forward FFT');
else
    disp('backward FFT');
end

x=x';
N=length(x);
indexOrig=0:(N-1);
indexOrigBin=dec2bin(indexOrig);
% Shuffling (bit reversal)
indexReversedBin=indexOrigBin(:,end:-1:1);
indexReversed=bin2dec(indexReversedBin);
xout=x(indexReversed+1);

%Number of stages
v=log(N)/log(2);
%Perform the v stages
for m=1:v
    xin=xout;
    selector=boolean(bin2dec(indexOrigBin(:,v-m+1)));
    in1=xin(selector==0);
    in2=xin(selector==1);
    
    
    [dummy1,dummy2]=ourButterfly(in1,in2,m,back);
    
%   REARRANGE THE OUTPUTS OF THE BUTTERFLY TO USE THEM AS INPUT IN THE NEXT
%   STAGE
    xdummy=[dummy1(:) dummy2(:)]';
    xdummy=xdummy(:);
    for i=1:(m-1)
        dummy1=xdummy(selector==0);
        dummy2=xdummy(selector==1);
        xdummy=[dummy1(:) dummy2(:)]';
        xdummy=xdummy(:);
    end
    xout=xdummy;
end

X=xout';
% IF WE ARE DOING INVERSE FFT, WE NEED TO DIVIDE BY N
if(back==1)
    X=X/N;
end