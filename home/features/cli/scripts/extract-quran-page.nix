{ pkgs }:

pkgs.writeShellScriptBin "extract-quran-page" ''
  #!/usr/bin/env bash
  #/ DESCRIPTION:
  #/   Extract a page from Al Quran Taddabur wa 'Aaml
  #
  #/ USAGE:
  #/   extract-quran-page PAGE...
  #
  #/ EXAMPLES:
  #/   extract-quran-page 225 226 227

  set -euo pipefail

  PDF_PATH=$HOME/Documents/pdf/15_QuranTddbrAmalMofhrss.pdf
  OUTDIR=$HOME/Pictures/quran

  print_help() {
    grep '^#/' <"$0" | cut -c 4-
    exit 0
  }

  if [[ "$#" -gt 0 ]]; then
    mkdir -p "$OUTDIR"
    cd "$OUTDIR" || exit 1
    for page in "$@"; do
      pnum="$((page + 10))"
      pdfimages -png -f "$pnum" -l "$pnum" "$PDF_PATH" quran
      mv "$OUTDIR/quran-000.png" "$OUTDIR/''${page}.png"
    done
  else
    print_help
  fi
''
