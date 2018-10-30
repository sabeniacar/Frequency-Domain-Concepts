%takes parameters "n" as tap number,"a" as alpha, "k" as delay
%"nu" as length of original audio,"su" as size of original audio,
%"u" as original audio and Fs as sampling rate of audio

function y = n_tap_filter(n,a,k,nu,su,u,Fs)
    %k is 0.1 by default
    if ~exist('k', 'var')
    k = 0.1;
    end
    
    y = zeros(su);

%apply the formula of n tap filter y(n')=x(n')-a*x(n'-k*fs)....(-a)^n*x(n'-k*n*fs)  
    for j=1:nu
       sum=0;
        for b=0:n
            if (j-b*k*Fs)<1  %if previous samples are nonexistent make them zero

                sum = sum + ((-a)^b)*0;
            else

                sum = sum + ((-a)^b)*u(int64(j-b*k*Fs));
            end
        end
        y(j) = sum; %calculate output
        
    end
end