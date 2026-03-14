class SciclawClaudeAgent < Formula
  desc "Claude Agent SDK bridge for sciClaw Claude OAuth users"
  homepage "https://github.com/drpedapati/sciclaw-claude-agent"
  license "MIT"
  version "0.1.2"

  url "https://github.com/drpedapati/sciclaw-claude-agent/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "968070aef91e4a52ab74ea5c13af91a6b53884823f79f0b8338fc6f0ebb32a57"

  depends_on "node"

  resource "claude-agent-sdk" do
    url "https://registry.npmjs.org/@anthropic-ai/claude-agent-sdk/-/claude-agent-sdk-0.2.76.tgz"
    sha256 "677800ffcbf46f6c948022e20d8f416fc399dcedb40064a9b55e344137cad46e"
  end

  def install
    libexec.install "bin", "src", "package.json", "README.md"

    sdk_target = libexec/"node_modules"/"@anthropic-ai"/"claude-agent-sdk"
    sdk_target.parent.mkpath
    resource("claude-agent-sdk").stage do
      mv "package", sdk_target
    end

    (bin/"sciclaw-claude-agent").write_env_script libexec/"bin/sciclaw-claude-agent.js",
      NODE_PATH: libexec/"node_modules",
      PATH: "#{Formula["node"].opt_bin}:#{ENV["PATH"]}"
  end

  test do
    assert_match "Usage: sciclaw-claude-agent", shell_output("#{bin}/sciclaw-claude-agent --help")
    assert_match version.to_s, shell_output("#{bin}/sciclaw-claude-agent --version")
  end
end
