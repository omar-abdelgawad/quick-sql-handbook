#!/bin/bash

packages=("pandoc" "texlive" "texlive-selnolig")

for package in "${packages[@]}"; do
    if ! dnf list installed "$package" &>/dev/null; then
        echo "$package is not installed. Installing..."
        sudo dnf install -y "$package"
    else
        echo "$package is already installed."
    fi
done

pandoc SQL.md \
	-o sql.pdf \
	--pdf-engine=lualatex \
	-V latex/'mainfont:times.otf' \
	--listings \
	-H latex/headers.tex \
	-V colorlinks=true \
	-V linkcolor=blue \
	-V classoption=table
