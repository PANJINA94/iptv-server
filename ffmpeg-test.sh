#!/bin/bash
STREAM_URL="https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"
OUTPUT_FILE="test.ts"
ffmpeg -i "$STREAM_URL" -t 10 "$OUTPUT_FILE" -y
echo "Done! File saved as $OUTPUT_FILE"
