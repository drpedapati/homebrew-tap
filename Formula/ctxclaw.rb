class Ctxclaw < Formula
  desc "Prompt context optimizer for agent runtimes"
  homepage "https://github.com/drpedapati/ctxclaw"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.2/ctxclaw-darwin-arm64"
      sha256 "2ba2554cb241c448a64fd3f9d3492f037ad2de3d9cbfa042dc9178bba0fe993b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.2/ctxclaw-linux-arm64"
      sha256 "88f8bae0b7162c805b3e750e660601d4841680e1609c105264b31d3702440e84"
    end
    on_intel do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.2/ctxclaw-linux-amd64"
      sha256 "aadca3918067fa60ec7dba227b678c5bdbbe93146e7315a7e32fdb5925d229ad"
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
