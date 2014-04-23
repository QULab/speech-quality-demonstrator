all: de-speech
	echo "Finished building all"

codecs = %.g722plc0.raw.wav \
%.gsm-full-rate.wav \
%.lpc.wav \
%.gsm-full-rate.wav \
%.enc192k-mp3.wav

effects = %.echo.wav %.whitenoise.wav %.pinknoise.wav

packet-loss = \
%.plr02.g722plc0.raw.wav \
%.plr02.g722plc1.raw.wav \
%.plr02.g722plc2.raw.wav \
%.plr02.g722plc3.raw.wav \
%.plr05.g722plc0.raw.wav \
%.plr05.g722plc1.raw.wav \
%.plr05.g722plc2.raw.wav \
%.plr05.g722plc3.raw.wav \
%.plr10.g722plc0.raw.wav \
%.plr10.g722plc1.raw.wav \
%.plr10.g722plc2.raw.wav \
%.plr10.g722plc3.raw.wav \
%.plr20.g722plc0.raw.wav \
%.plr20.g722plc1.raw.wav \
%.plr20.g722plc2.raw.wav \
%.plr20.g722plc3.raw.wav \
%.plr50.g722plc0.raw.wav \
%.plr50.g722plc1.raw.wav \
%.plr50.g722plc2.raw.wav \
%.plr50.g722plc3.raw.wav

band = \
%.narrowband.wav \
%.wideband.wav

% : $(codecs) $(effects) $(packet-loss) $(band)
	echo "Finished $@."

include Makefile.mk