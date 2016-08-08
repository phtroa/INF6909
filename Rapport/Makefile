OUTPUTDIR=build
FILENAME=main.tex
PDFRAWNAME=$(FILENAME:.tex=.pdf)
OUTPUTNAME=rapport_inf6909_troclet_philippe.pdf
all:
	test -d build || mkdir build
	latexmk -outdir=${OUTPUTDIR} -pdf ${FILENAME}
	cp ${OUTPUTDIR}/${PDFRAWNAME} .
	mv ${PDFRAWNAME} ${OUTPUTNAME}

clean:
	rm -r ${OUTPUTDIR}  ${OUTPUTNAME} 
