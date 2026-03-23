class SciclawWebchat < Formula
  desc "sciClaw webchat — Discord-quality Spacebar client for institutional collaboration"
  homepage "https://chat.sciclaw.dev"
  url "https://github.com/drpedapati/sciclaw-webchat/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "5d19d42e3cccf378b6b7635ec32499036785830808b27b7e30a1aeb6e0afb727"
  license "GPL-3.0"

  depends_on "node@20"

  def install
    system "npm", "ci", "--ignore-scripts"
    system "npm", "run", "build"

    libexec.install Dir["*"]

    (bin/"sciclaw-webchat").write <<~EOS
      #!/bin/bash
      export PORT="${PORT:-8080}"
      exec "#{Formula["node@20"].bin}/node" "#{libexec}/dist/index.js" "$@"
    EOS
  end

  def caveats
    <<~EOS
      sciClaw webchat (Discord-quality Spacebar client)

      Run:     sciclaw-webchat
      Service: brew services start sciclaw-webchat
      Open:    http://localhost:8080

      Default port: 8080 (override with PORT env var)

      Connects to api.sciclaw.dev by default.
      Edit #{libexec}/dist/webpage/instances.json to change.
    EOS
  end

  service do
    run [bin/"sciclaw-webchat"]
    keep_alive true
    log_path var/"log/sciclaw-webchat.log"
    error_log_path var/"log/sciclaw-webchat-error.log"
    environment_variables PORT: "8080"
  end

  test do
    assert_predicate libexec/"dist/index.js", :exist?
  end
end
