class Ctxclaw < Formula
  desc "Prompt context optimizer for agent runtimes"
  homepage "https://github.com/drpedapati/ctxclaw"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.0/ctxclaw-darwin-arm64"
      sha256 "4b20a30cb76e272c2b661db8b7cd9209c196394e8577d04e2f12430feb28f08e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.0/ctxclaw-linux-arm64"
      sha256 "c633193835a8cbffbd424a76b460a030d80344d656beed96cc37089b97ad0295"
    end
    on_intel do
      url "https://github.com/drpedapati/homebrew-tap/releases/download/ctxclaw-v0.1.0/ctxclaw-linux-amd64"
      sha256 "14d500e889596fbe7dc7cae8ea074008fa30e526c5e1dcc540bae5a2f927d969"
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
