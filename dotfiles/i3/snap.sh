#!/usr/bin/env bash
set -e
OUTDIR="$HOME/Dropbox/Public/Screenshots"
USER_ID=12379861
DB_BASE_URL="https://dl.dropboxusercontent.com/u/${USER_ID}/Screenshots"
IMG="$(uuidgen).png"
scrot -s "${OUTDIR}/${IMG}"
URL="${DB_BASE_URL}/${IMG}"
echo $URL | xsel --clipboard --input
notify-send "Copied link to clipboard"
