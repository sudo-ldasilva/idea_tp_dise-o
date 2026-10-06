#!/bin/bash

error() {
    notify-send "tp_diseño was NOT uploaded" "$1"
    echo "[ERROR] $1"
}

upload_changes() {
    git add index.html
    if [[ $? -ne 0 ]]; then
        error "Git add error"
    fi

    git commit -m "[update] $(date)"
    if [[ $? -ne 0 ]]; then
        error "Git commit error"
    fi

    git push
    if [[ $? -ne 0 ]]; then
        error "Git push error"
    fi
}

generate_html() {
    idea html index.html tp_diseño
    if [[ $? -ne 0 ]]; then
        error "Unable to generate the HTML"
    fi
}

cd "$(dirname "$0")"

generate_html

if [[ ! -z "$(git diff index.html)" ]]; then
    upload_changes
fi
