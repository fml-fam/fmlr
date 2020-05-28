all: docs

docs:
	( Rscript -e "pkgdown::build_site('..', override=list(destination='docs/html'), install=FALSE)" )

articles: vignettes
	( Rscript -e "pkgdown::build_articles('..', override=list(destination='docs/html'))" )

vignettes:
	( cd ../vignettes && Rscript ./rebuild.r )

clean:
	rm -rf html
