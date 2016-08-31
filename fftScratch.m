clear all;

x=r;%[1 2 3 4 3 2 1 0]';
N=length(x);
indexOrig=0:(N-1);
indexOrigBin=dec2bin(indexOrig);
% Shuffling (bit reversal)
indexReversedBin=indexOrigBin(:,end:-1:1);
indexReversed=bin2dec(indexReversedBin);

% totStages=3;

% Stage 1
xout=x(indexReversed+1);

v=log(N)/log(2);
for m=1:v
    xin=xout;
    selector=boolean(bin2dec(indexOrigBin(:,v-m+1)));
    in1=xin(selector==0);%indexReversed(~selector)+1);
    in2=xin(selector==1);%indexReversed(selector)+1);
    
    % k=0:length(in1)-1;
    [dummy1,dummy2]=ourButterfly(in1,in2,m,);
    
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


%
% out1=xout(indexReversed(~selector)+1);
% out2=xout(indexReversed(selector)+1);
% xout=[out1(:);out2(:)];
%
% for
% x


% butter(x)