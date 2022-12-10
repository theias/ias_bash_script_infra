SHELL := /bin/bash

all: README.md

README.md: run_an_unaware_of_infra_script.sh
	cat ./run_an_unaware_of_infra_script.sh  <(grep -vE '^#\\' run_an_unaware_of_infra_script.sh | sed '/^$$/N;/^\n$$/D' ) | ias-de-embed_markdown.pl > README.md
