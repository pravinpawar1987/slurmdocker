subdir = almalinux-8

.PHONY: all build clean test $(subdir)

all: build

build: $(subdir)

clean: $(subdir)

$(subdir):
	$(MAKE) -C $@ $(MAKECMDGOALS)
