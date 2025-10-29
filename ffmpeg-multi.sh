#!/bin/bash
M3U_URL="https://raw.githubusercontent.com/PANJINA94/test/master/test.m3u"
OUTPUT_DIR="streams"
mkdir -p $OUTPUT_DIR

echo "Downloading channels from $M3U_URL ..."
curl -s $M3U_URL | grep -E "http" | while read STREAM; do
    NAME=$(echo $STREAM | md5sum | cut -d' ' -f1)
    echo "Downloading $STREAM ..."
    ffmpeg -i "$STREAM" -t 10 "$OUTPUT_DIR/$NAME.ts" -y
done

echo "All streams saved in $OUTPUT_DIR/"
