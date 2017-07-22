default: pdf clean

VERSION=$(shell git describe --tags --dirty)


pdf: version
	mkdir -p pdf
	cd src && pdflatex --output-directory=../pdf --jobname=version_test main.tex


version:
	@echo $(VERSION) > src/document_version_from_git.tex


clean:
	rm -rf pdf/*.log pdf/*.aux
