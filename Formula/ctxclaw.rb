class Ctxclaw < Formula
  desc "Prompt context optimizer for agent runtimes"
  homepage "https://github.com/drpedapati/ctxclaw"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.1/ctxclaw-darwin-arm64"
      sha256 "c09926029a82b29ee273932dad42f500e1df7732c244bc8520821f98ff3c1c0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.1/ctxclaw-linux-arm64"
      sha256 "e72e391d2593fc12567281317f7390a2e459f9063cb1e66dabe42041ac39dfd7"
    end
    on_intel do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.1/ctxclaw-linux-amd64"
      sha256 "cf9022c1093b7e999e06a3ee49c49e16c901e65f0b892accc09104afaa765da9"
    end
  end

  def install
    if OS.mac?
      bin.install "ctxclaw-darwin-arm64" => "ctxclaw"
    elsif OS.linux? && Hardware::CPU.arm?
      bin.install "ctxclaw-linux-arm64" => "ctxclaw"
    else
      bin.install "ctxclaw-linux-amd64" => "ctxclaw"
    end
  end

  test do
    assert_match "ctxclaw", shell_output("#{bin}/ctxclaw version")
    assert_match "version:", shell_output("#{bin}/ctxclaw 2>&1", 2)
  end
end
