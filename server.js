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
  } else if (req.url === "/ffmpeg-multi") {
    exec("bash ffmpeg-multi.sh", (error, stdout, stderr) => {
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
    res.end("✅ IPTV Test Server is running! Use /ffmpeg or /ffmpeg-multi");
  }
});

server.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
