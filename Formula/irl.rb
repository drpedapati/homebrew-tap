class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.4/irl-darwin-arm64"
      sha256 "3415d0b273b248773217314d058f009c6dc0e25d9a87f1f758c5a8d0e564aa85"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.4/irl-darwin-amd64"
      sha256 "fc00ff64c4de9484ccdb47cb023749e5b230b7ca1856de172ba085a00ca29bdd"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.3.4/irl-linux-amd64"
    sha256 "5d209614a0c70597a53efea9c39b9c89b52e7ebbdfac4149bf1dda8575a0796b"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
