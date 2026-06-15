# Makefile for Typst CV — wraps build.sh

ROLES := ai lead fullstack
LANGS := en de

.PHONY: all base roles clean help

help:
	@echo "Targets:"
	@echo "  make            # base CV (English)"
	@echo "  make all        # base + all roles, both languages (en, de)"
	@echo "  make base       # base CV, both languages"
	@echo "  make roles      # all role variants, both languages"
	@echo "  make ai|lead|fullstack   # one role, both languages"
	@echo "  make clean      # remove output/"

# Default: base English CV
base-en:
	./build.sh

# base CV in every language
base:
	@for lang in $(LANGS); do ./build.sh -l $$lang; done

# every role in every language
roles:
	@for role in $(ROLES); do \
		for lang in $(LANGS); do \
			./build.sh -r $$role -l $$lang; \
		done; \
	done

# per-role convenience targets (both languages)
$(ROLES):
	@for lang in $(LANGS); do ./build.sh -r $@ -l $$lang; done

# everything
all: base roles
	@echo "✅ Built all CV variants in output/"

clean:
	rm -rf output
