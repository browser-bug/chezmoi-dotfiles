#!/usr/bin/env bash

MIME=$(file -b --mime-type "$1")

case "$MIME" in
    # .pdf
    *application/pdf*)
        #pdftotext "$1" -
        ctpv "$1"
        ;;
    # .images
    *image/*)
        ctpv "$1"
        ;;
    # .7z
    *application/x-7z-compressed*)
        7z l "$1"
        ;;
    # .tar .tar.Z
    *application/x-tar*)
        tar -tvf "$1"
        ;;
    # .tar.*
    *application/x-compressed-tar*|*application/x-*-compressed-tar*)
        tar -tvf "$1"
        ;;
    # .rar
    *application/vnd.rar*)
        unrar l "$1"
        ;;
    # .zip
    *application/zip*)
        unzip -l "$1"
        ;;
    # any plain text file that doesn't have a specific handler
    *)
        # return false to always repaint, in case terminal size changes
        bat --force-colorization --paging=never --style=changes,numbers --terminal-width $(($2 - 3)) "$1"
        ;;
esac
