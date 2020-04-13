# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
SOURCE_DOCS := $(wildcard *.md)

EXPORTED_DOCS=\
 $(SOURCE_DOCS:.md=.html) \
 $(SOURCE_DOCS:.md=.pdf) \
 $(SOURCE_DOCS:.md=.docx) \
 $(SOURCE_DOCS:.md=.rtf) \
 $(SOURCE_DOCS:.md=.odt) \
 $(SOURCE_DOCS:.md=.epub)

RM=/bin/rm

PANDOC_OPTIONS= --standalone

PANDOC_HTML_OPTIONS= --to html5
PANDOC_PDF_OPTIONS= --pdf-engine=xelatex -V geometry:a4paper -V linkcolor:blue -f gfm --table-of-contents --number-sections
PANDOC_DOCX_OPTIONS=
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=
PANDOC_EPUB_OPTIONS= --to epub3


# Pattern-matching Rules

%.html : %.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

%.pdf : %.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
	
%.docx : %.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

%.rtf : %.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<

%.odt : %.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<

%.epub : %.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<


# Targets and dependencies

.PHONY: all clean

all : $(EXPORTED_DOCS)

clean:
	- $(RM) $(EXPORTED_DOCS)
