#!/bin/bash
# FFmpeg IPTV Test Script
# Pokreće testni IPTV stream i čuva ga lokalno

# Provjera da li ffmpeg postoji, ako ne instalira
if ! command -v ffmpeg &> /dev/null
then
    echo "FFmpeg nije instaliran. Instalira se..."
    sudo apt update && sudo apt install -y ffmpeg
fi

# Test IPTV stream (M3U8)
STREAM_URL="https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"
OUTPUT_FILE="test.ts"

echo "Preuzimanje test streama sa $STREAM_URL ..."
ffmpeg -i "$STREAM_URL" -t 10 "$OUTPUT_FILE"

echo "Gotovo! Fajl $OUTPUT_FILE je spremljen na serveru."
const { exec } = require("child_process");

const http = require("http");
const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  if (req.url === "/ffmpeg") {
    exec("bash ffmpeg-test.sh", (error, stdout, stderr) => {
      if (error) {
        res.end(`Error: ${error.message}`);
        return;
      }
      if (stderr) {
        res.end(`Stderr: ${stderr}`);
        return;
      }
      res.end(`Output:\n${stdout}`);
    });
  } else {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("✅ IPTV Test Server is running! Access /ffmpeg to test stream");
  }
});

server.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
chmod +x ffmpeg-test.sh
