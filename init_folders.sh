#!/bin/bash

ROOT=${ROOT:-/path/to/media}
CONFIG_ROOT="${ROOT}/config"
COMPLETE_ROOT="${ROOT}/complete"
SABNZBD_ROOT="${ROOT}/sabnzbd"
INCOMPLETE_DOWNLOADS="${SABNZBD_ROOT}/incomplete/downloads"

declare -A FOLDERS=(
    ["${CONFIG_ROOT}/plex/db"]="Plex database"
    ["${CONFIG_ROOT}/plex/transcode"]="Plex transcode temp files"
    ["${CONFIG_ROOT}/sonarr"]="Sonarr config"
    ["${CONFIG_ROOT}/bazarr"]="Bazarr config"
    ["${SABNZBD_ROOT}/config"]="SABnzbd config"
    ["${COMPLETE_ROOT}"]="Media library (complete downloads)"
    ["${COMPLETE_ROOT}/tv"]="TV shows library"
    ["${COMPLETE_ROOT}/movies"]="Movies library"
    ["${INCOMPLETE_DOWNLOADS}"]="Incomplete downloads"
)

PUID=${PUID:-1000}
PGID=${PGID:-1000}

echo "Tarkistetaan ja luodaan tarvittavat kansiot..."
for FOLDER in "${!FOLDERS[@]}"; do
    if [ ! -d "$FOLDER" ]; then
        echo "Luodaan ${FOLDERS[$FOLDER]}: $FOLDER"
        mkdir -p "$FOLDER"
        chown $PUID:$PGID "$FOLDER"
    else
        echo "Kansio löytyy jo: $FOLDER"
    fi
done

echo "Kansiorakenne valmis!"
