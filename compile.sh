#!/bin/bash

if command -v dnf &>/dev/null; then
    echo "Detected Fedora-based system."
    if ! dnf list installed pandoc &>/dev/null; then
        echo "Installing pandoc..."
        sudo dnf install -y pandoc
    fi
    if ! dnf list installed texlive &>/dev/null; then
        echo "Installing texlive..."
        sudo dnf install -y texlive
    fi
    if ! dnf list installed texlive-selnolig &>/dev/null; then
        echo "Installing texlive-selnolig..."
        sudo dnf install -y texlive-selnolig
    fi
elif command -v apt &>/dev/null; then
    echo "Detected Ubuntu-based system."
    if ! dpkg -l | grep -q pandoc; then
        echo "Installing pandoc..."
        sudo apt install -y pandoc
    fi
    if ! dpkg -l | grep -q texlive-latex-recommended; then
        echo "Installing texlive-latex-recommended..."
        sudo apt install -y texlive-latex-recommended
    fi
    if ! dpkg -l | grep -q texlive-luatex; then
        echo "Installing texlive-luatex..."
        sudo apt install -y texlive-luatex
    fi
else
    echo "Unsupported package manager. Please install dependencies manually."
    exit 1
fi

# Compile markdown to PDF using pandoc
pandoc SQL.md \
    -o build/sql.pdf \
    --pdf-engine=lualatex \
    -V latex/'mainfont:times.otf' \
    --listings \
    -H latex/headers.tex \
    -V colorlinks=true \
    -V linkcolor=blue \
    -V classoption=table
