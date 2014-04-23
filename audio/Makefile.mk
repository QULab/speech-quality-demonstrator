#Dennis Guse, 2014
#Version 0.02
#Add audio files to build! (without .wav suffix)
#Do not use any "." in your input filenames except for .wav, which is implied
#The filename contains all modifications steps of the resulting file.

#Keep all intermediate depencencies
.SECONDARY:


#Cleaning using GIT - not the nicest one....
#Better would be not setting .SECONDARY: and get all dependencies of .SECONDARY...
clean:
#	git clean -f
	rm -f *.*.wav *.raw *.mp3 *.g192


#AMR-wb
#AMR-nb
#opus: opus-tools

ITUSTL = stl2009/binUnix/

##Codecs
%.gsm-full-rate.wav: %.wav
	sox $< --encoding=gsm-full-rate $@.tmp.gsm
	sox $@.tmp.gsm --encoding=signed-integer $@
	rm $@.tmp.gsm

%.g711.wav: %.wav
	sox $< --encoding=a-law $@

%.lpc.wav: %.wav
	sox $< $*.lpc
	sox $*.lpc $@
	rm $*.lpc

%.enc192k-mp3.wav : %.enc192k.mp3
	sox $< $@

%.enc192k.mp3 : %.wav
	sox $< -C 192 $@

##G.722 using ITU-T STL (2009): Encode
%.g722.g192 : %.raw
	$(ITUSTL)/encg722 $< $@
##G.722 using ITU-T STL (2009): Decode
%.g722plc0.raw : %.g722.g192
	$(ITUSTL)/decg722 $< $@
%.g722plc1.raw : %.g722.g192
	$(ITUSTL)/decg722 -plc 1 $< $@
%.g722plc2.raw : %.g722.g192
	$(ITUSTL)/decg722 -plc 2 $< $@
%.g722plc3.raw : %.g722.g192
	$(ITUSTL)/decg722 -plc 3 $< $@

#Packet-loss for G.192 bitstreams using ITU-T STL (2009)
%.plr02.g722.g192 : %.g722.g192
	$(ITUSTL)/eid-xor -ep byte -fer $< plr.02 $@
%.plr05.g722.g192 : %.g722.g192
	$(ITUSTL)/eid-xor -ep byte -fer $< plr.05 $@
%.plr10.g722.g192 : %.g722.g192
	$(ITUSTL)/eid-xor -ep byte -fer $< plr.10 $@
%.plr20.g722.g192 : %.g722.g192
	$(ITUSTL)/eid-xor -ep byte -fer $< plr.20 $@
%.plr50.g722.g192 : %.g722.g192
	$(ITUSTL)/eid-xor -ep byte -fer $< plr.50 $@




##Sampling
%.sample16k.wav : %.wav
	sox $< -r 16k $@

##Noise
%.whitenoise.wav : %.wav
	sox $< -p synth whitenoise vol 0.02 | sox --combine mix-power $< - $@

%.pinknoise.wav : %.wav
	sox $< -p synth pinknoise vol 0.04 | sox --combine mix-power $< - $@

##Echo 
%.echo.wav : %.wav
	sox  $< $@ echo 1 1 100 .5

##Bandpass
%.narrowband.wav : %.wav
	sox $< -r 8000 $@

%.wideband.wav : %.wav
	sox $< -r 16000 $@

#Conversion: wave to raw (used by ITU-T STL encoder of G.722 encoder): 16k signed linear
%.raw : %.wav
	sox $< -r 16k -e signed -b 16 -c 1 $@
%.raw.wav : %.raw
	sox -r 16k -e signed -b 16 -c 1 $< $@
