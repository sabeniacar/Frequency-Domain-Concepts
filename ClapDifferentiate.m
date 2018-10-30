prompt = 'Enter the name of the file in single quotation marks';
file = input(prompt); 
[y, Fs] = audioread(file);

%make decibels lower than -60 zero
[S,F,T,P]=spectrogram(y(:,1),'MinThreshold',-60);

P1=P(F > 0.8*pi,:); %take part where frequency is greater than 0.8*pi

%for claps power density should be 0 after the frequency 0.8*pi when
%the decibels lower than -60 are made zero

if ~any(P1)==1
    disp('clap sound detected')
else
    disp('snap sound detected')
end

