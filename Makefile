default: pdf clean

VERSION=$(shell git describe --tags --dirty)
TIMESTAMP=$(shell date +%F_%H-%M-%S)


pdf: version
	mkdir -p pdf
	cd src && pdflatex --output-directory=../pdf --jobname=version_test_$(TIMESTAMP) main.tex


version:
	@echo $(VERSION) > src/document_version_from_git.tex


clean:
	rm -rf pdf/*.log pdf/*.aux
