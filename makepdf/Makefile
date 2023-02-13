slutpdf = doc.docpdf doc.footpdf

%.footpdf : %.ftxt ; pdfbox TextToPDF -fontSize 6 -ttf /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf  $@ $<
%.docpdf : %.txt ; pdfbox TextToPDF -fontSize 7 -ttf /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf   $@ $<

doc.pdf :  $(slutpdf)
	pdfbox OverlayPDF $(slutpdf) doc.pdf
	rm -f *footpdf *docpdf

doc.footpdf : doc.ftxt
doc.docpdf : doc.txt

.PHONY:
clean :
	rm -f *pdf

.PHONY:
rmtemp :
	rm -f *footpdf *docpdf