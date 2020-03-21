# Minimal makefile for Sphinx documentation
#
.PHONY: upload

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = install_new_computer
SOURCEDIR     = .
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

upload:
	rsync -rv build/html/ ubuntu@mywebsite:/home/docs/pages/install_new_computer

open:
	open build/html/index.html

pdf:
	@make latexpdf
	@cp -a _build/latex/*.pdf ../docs
	@make clean

github:
	@make html
	@cp -a build/html/. ../docs
	@make clean

sync: html upload

see: html open

