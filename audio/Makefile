#Dennis Guse, 2014

codecs = audio1.g722.raw.wav \
audio1-lpc.wav \
audio1-enc192k-mp3.wav

effects = audio1.echo.wav audio1.whitenoise.wav

packet-loss = audio1.g722.loss.raw.wav



all : $(codecs) $(effects) $(packet-loss)

clean :
	rm -f $(codecs)
	rm -f $(effects)
	rm -f $(packet-loss)

#AMR-wb
#AMR-nb
#opus: opus-tools

ITUSTL = stl2009/binUnix/

##Codecs
%.gsm-full-rate.wav: %.wav
	sox --encoding=gsm-full-rate $< $@

%.g711.wav: %.wav
	sox --encoding=a-law $< $@

%.lpc.wav: %.lpc
	sox $< $@
%.lpc : %.wav
	sox $< $@

%-enc192k-mp3.wav : %-enc192k.mp3
	sox $< $@

%-enc192k.mp3 : %.wav
	sox $< -C 192 $@

#G.722 using avconv
%.g722.wav : %.g722
	avconv -i $< $@

%.g722 : %-sample16k.wav
	avconv -i $< $@

#G.722 using ITU-T STL (2006)
%.g722.raw : %.g722.g192
	$(ITUSTL)/decg722 $< $@

%.g722.g192 : %.raw
	$(ITUSTL)/encg722 $< $@

%.g722.loss.raw : %.g722.loss.g192
	$(ITUSTL)/decg722 $< $@

#Packet-loss for G.192 bitstreams using ITU-T STL (2006)
%.loss.g192 : %.g192
	$(ITUSTL)/eid-xor -fer -ep byte $< errorpattern $@

##Sampling
%.sample16k.wav : %.wav
	sox $< -r 16k $@

##Noise
%.whitenoise.wav : %.wav
	sox $< -p synth whitenoise vol 0.02 | sox -m $< - $@

##Echo 
%.echo.wav : %.wav
	sox $< $@ echo .5 .5 100 .5

#Conversion: wave to raw (used by G.722 encoder): 16k signed linear
%.raw : %.wav
	sox $< -r 16k -e signed -b 16 -c 1 $@
%.raw.wav : %.raw
	sox -r 16k -e signed -b 16 -c 1 $< $@