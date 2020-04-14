all: download setup compile_all

download:
	./scripts/download.sh

setup:
	./scripts/setup.sh

compile_all:
	./scripts/compile.py all

clean:
	./scripts/uninstall.sh;

.PHONY: compile_speed compile_rate compile_all bitcode setup optimization binary run clean
