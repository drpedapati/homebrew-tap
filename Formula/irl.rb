class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.5/irl-darwin-arm64"
      sha256 "cde6c9e8b3f1995f1e1f0f2c98ec398678db95ca36ff64c91b19bd0bad1584f7"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.5/irl-darwin-amd64"
      sha256 "192d40dd019fb90f2bb268033727faae30a2f60661214d9c446d57bd2607be92"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.3.5/irl-linux-amd64"
    sha256 "2d7ec566046d93e5a757d6326a6cf6c23ba342f68afe4cea2fb8f64fab502c8d"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
