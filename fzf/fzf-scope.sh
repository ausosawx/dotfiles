#!/bin/bash

case "$1" in
	*.pdf) zathura "$1" ;;
	*) bat --color=always --italic-text=always --style=numbers,changes,header --line-range :500 "$1" ;;
esac
