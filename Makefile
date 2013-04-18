DOC = apsys13
#
# change this line to contain the name of the document without extension

TARGETS = $(DOC).pdf
#
# TARGETS could be $(DOC).dvi instead, if there are no figures

TEXS = $(DOC).tex sigplanconf.cls ttquot.sty macros.tex \
       intro.tex cases.tex usage.tex implementations.tex conclusion.tex \
			 $(DOC).bbl $(BIBFILE)
#
# Add any included TeX files to TEXS

FIGS = 

#
# List of postscript figures to be included

MAKEDIR=.
include $(MAKEDIR)/commondefs
TEXDIR=.

default: $(TARGETS)

BIBFILE = $(DOC).bib
#
# Ignore this if you're not using bibtex. Change the $(DOC) part if your bib
# file has a different name from your document
#
$(DOC).dvi: $(TEXS) $(FIGS) $(DOC).stamp $(DOC).bbl $(BIBFILE)
$(DOC).pdf: $(TEXS) $(FIGS) $(DOC).stamp $(DOC).bbl $(BIBFILE)
#
# To use bibtex, add these to dependency list:
# $(DOC).bbl $(BIBFILE)
# 
# To use makeindex, add this to dependency list:
# $(DOC).ind
#
# To use glossaries, add this to dependency list:
# $(DOC).glo

$(DOC).bbl: $(BIBFILE) $(DOC).stamp
$(DOC).glo $(DOC).ind: $(DOC).stamp
$(DOC).ps: $(DOC).dvi $(FIGS)
#
# These are standard dependencies. Shouldn't need to modify these.

VPATH = figures

include $(COMMONRULES)

ASPELL_CMDS=\
        --add-tex-command="autoref p" \
        --add-tex-command='bibliography p' \
        --add-tex-command='bibliographystyle p' \
        --add-tex-command='cc p' \
        --add-tex-command='mathrm p' \
        --add-tex-command='newcommand pp' \
        --add-tex-command='renewcommand pp' \

spell:
	@ for i in *.tex; do aspell -t $(ASPELL_CMDS) -p ./aspell.words -c $$i; done
	@ ( head -1 aspell.words ; tail -n +2 aspell.words | sort ) > aspell.words~
	@ mv aspell.words~ aspell.words

