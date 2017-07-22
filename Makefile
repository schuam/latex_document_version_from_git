default: pdf clean

VERSION=$(shell git describe --tags --dirty)


pdf: version
	mkdir -p pdf
	cd src && pdflatex --output-directory=../pdf --jobname=version_test git_version_test.tex


version:
	@echo $(VERSION) > src/git_version.tex


clean:
	rm -rf pdf/*.log pdf/*.aux
