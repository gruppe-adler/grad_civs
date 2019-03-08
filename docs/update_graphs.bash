#!/usr/bin/env bash

docdir=$(dirname $0)
dot -Tsvg ${docdir}/states.gv > ${docdir}/states.svg
dot -Tpng ${docdir}/states.gv > ${docdir}/states.png
