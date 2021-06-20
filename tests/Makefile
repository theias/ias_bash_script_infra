MAKEFILE_PATH = $(strip $(dir $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/bash

bin_dir=$(MAKEFILE_PATH)../src/bin

.PHONY: debug
debug:
	@echo "Makefile path: $(MAKEFILE_PATH)"
	@echo "bin_dir: $(bin_dir)"

.PHONY: test_all_units
test_all_units: \
	test_main_scripts \
	test_pidfile_scripts

.PHONY: test_main_scripts
test_main_scripts:
	make -f $(MAKEFILE_PATH)/Makefile_MainScripts test_all_main_scripts

.PHONY: test_pidfile_scripts
test_pidfile_scripts:
	make -f $(MAKEFILE_PATH)/Makefile_PidFile test_all_pidfile_things
