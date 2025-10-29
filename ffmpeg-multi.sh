#!/bin/bash
M3U_URL=" http://exm3u.123tv.to:8080/c/" 
OUTPUT_DIR="streams"
mkdir -p $OUTPUT_DIR

echo "Downloading channels from $M3U_URL ..."
curl -s $M3U_URL | grep -E "http" | while read STREAM; do
    NAME=$(echo $STREAM | md5sum | cut -d' ' -f1)
    echo "Downloading $STREAM ..."
    ffmpeg -i "$STREAM" -t 10 "$OUTPUT_DIR/$NAME.ts" -y
done

echo "All streams saved in $OUTPUT_DIR/"
