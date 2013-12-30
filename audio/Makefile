all : audio1-gsm.wav audio1-lpc.wav audio1-amr-nb.wav

%-lpc.wav: %.wav
	sox $< $@
%-lpc: %.wav
	sox $< $@

%-gsm.wav: %.gsm
	sox $< $@
%.gsm: %.wav
	sox $< $@

%-g722.wav: %.g722 #Not working; use asterisk?
	sox $< $@
%.g722: %.wav
	sox $< $@

%-amr-nb.wav: %.amr-nb
	sox $< $@
%.amr-nb: %.wav
	sox $< $@

%-amr-wb.wav: %.amr-wb #Needs to be compiled into SOX.
	sox $< $@
%.amr-wb: %.wav
	sox $< $@