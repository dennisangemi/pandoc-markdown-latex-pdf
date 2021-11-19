#!/bin/sh

### requisiti ###
# pandoc
# pandoc-citeproc
# xelatex 
### requisiti ###

#leggere questo https://www.cyberciti.biz/faq/bash-loop-over-file/

CONTENTDIR="content"
BUILDDIR="build"
ASSETSDIR="assets"

git pull
echo "Updated!"

# Elimina la cartella con i file di output
rm -r "${BUILDDIR}"

# Crea la cartella con i file di output
mkdir "${BUILDDIR}" -p
echo "Creating PDF print output"

# Ciclo che converte ogni md in pdf
for filename in content/*.md; do
pandoc "$filename" \
     --resource-path="${CONTENTDIR}" \
     --citeproc \
     --csl="${ASSETSDIR}/citation-style.csl" \
     --from="markdown+tex_math_single_backslash+tex_math_dollars+raw_tex" \
     --to="latex" \
     --output="${BUILDDIR}/$filename.pdf" \
     --pdf-engine="xelatex" \
     --include-in-header="layouts/print.tex"
done

echo "Done!"

# Lo script originario era questo
#pdf_print() {
#    mkdir "${BUILDDIR}" -p
#    echo "Creating PDF print output"
#    pandoc "${CONTENTDIR}/${FILENAME}.md" \
#        --resource-path="${CONTENTDIR}" \
#        --citeproc \
#        --csl="${ASSETSDIR}/citation-style.csl" \
#        --from="markdown+tex_math_single_backslash+tex_math_dollars+raw_tex" \
#        --to="latex" \
#        --output="${BUILDDIR}/output_print.pdf" \
#        --pdf-engine="xelatex" \
#       --include-in-header="layouts/print.tex"
#}