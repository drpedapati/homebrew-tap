class SciclawServer < Formula
  desc "sciClaw server — Spacebar-compatible Discord backend with OIDC institutional login"
  homepage "https://api.sciclaw.dev"
  url "https://github.com/drpedapati/sciclaw-server/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "97428e0dd5eed00affd8d3bd111a607c998dce84d2b6c9bb370dae0888cc4ca8"
  license "AGPL-3.0"

  depends_on "node@20"

  def install
    system "npm", "ci", "--ignore-scripts"
    system "npx", "tsc", "-b"

    libexec.install Dir["*"]

    (bin/"sciclaw-server").write <<~EOS
      #!/bin/bash
      export NODE_ENV="${NODE_ENV:-production}"
      exec "#{Formula["node@20"].bin}/node" "#{libexec}/dist/bundle/start.js" "$@"
    EOS
  end

  def post_install
    (var/"sciclaw-server").mkpath
  end

  def caveats
    <<~EOS
      sciClaw server (Spacebar-compatible Discord backend)

      Config: #{var}/sciclaw-server/config.json
      Example: #{libexec}/config/sciclaw.config.example.json

      Endpoints (default):
        API:     http://localhost:3001/api/v9
        Gateway: ws://localhost:3001/
        CDN:     http://localhost:3001/

      Run:     sciclaw-server
      Service: brew services start sciclaw-server
    EOS
  end

  service do
    run [bin/"sciclaw-server"]
    keep_alive true
    working_dir var/"sciclaw-server"
    log_path var/"log/sciclaw-server.log"
    error_log_path var/"log/sciclaw-server-error.log"
  end

  test do
    assert_predicate libexec/"dist/bundle/start.js", :exist?
  end
end
