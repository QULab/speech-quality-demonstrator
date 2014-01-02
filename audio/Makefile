all : audio1-lpc.wav audio1-g722.wav audio1-enc192k-mp3.wav audio1-echo.wav audio1-whitenoise.wav

#AMR-wb
#AMR-nb
#opus: opus-tools

ITUSTL = stl2009/binUnix/

##Codecs
%-gsm-full-rate.wav: %.wav
	sox --encoding=gsm-full-rate $< $@

%-g711.wav: %.wav
	sox --encoding=a-law $< $@

%-lpc.wav: %.lpc
	sox $< $@
%.lpc : %.wav
	sox $< $@

%-enc192k-mp3.wav : %-enc192k.mp3
	sox $< $@

%-enc192k.mp3 : %.wav
	sox $< -C 192 $@

%-g722.wav : %.g722
	avconv -i $< $@

%.g722 : %-sample16k.wav
	avconv -i $< $@


##Sampling
%-sample16k.wav : %.wav
	sox $< -r 16000 $@

##Noise
%-whitenoise.wav : %.wav
	sox $< -p synth whitenoise vol 0.02 | sox -m $< - $@

%.g722.raw : %.g722.g192
	$(ITUSTL)/decg722 $< $@

%.g722.g192 : %.raw
	$(ITUSTL)/encg722 $< $@

##Echo 
%-echo.wav : %.wav
	sox $< $@ echo .5 .5 100 .5

#Conversion: wave to raw (used by G.722 encoder)
%.raw : %.wav
	sox $< -r 16000 -e signed -b 16 -c 1 $@
%.raw.wav : %.raw
	sox -r 16000 -e signed -b 16 -c 1 $< $@