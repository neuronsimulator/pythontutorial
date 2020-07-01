#!/bin/sh
# ------------------------------------------------------------
# Script to generate the html and .rst stubs to show the
# ipynb within Sphinx generated docs
#
# Requires jupyter nbconvert
# ------------------------------------------------------------
set -e

# Create a clean index.rst
echo "
Tutorials
=========

.. toctree::
   :maxdepth: 2
" > index.rst

for filename in *.ipynb; do
    jupyter nbconvert --to html $filename
    name="${filename%.*}"

    # Create stub rst
    echo "$name
----------------

.. raw:: html
   :file: $name.html
" > $name.rst

    # Add to index
    echo "   $name" >> index.rst

done