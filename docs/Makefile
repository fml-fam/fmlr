all: docs

docs:
	( Rscript -e "pkgdown::build_site('..', override=list(destination='docs/html'), install=FALSE)" )

clean:
	rm -rf html
