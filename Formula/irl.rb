class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.3/irl-darwin-arm64"
      sha256 "3049d45ee7db82c4a418bc87dadf3346f0c5284759a88d97986fc644e08a90e3"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.3/irl-darwin-amd64"
      sha256 "09e2285fd0e9e309da748b7de90af35e34d37ef09077fd2119d8eff2329e7298"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.3.3/irl-linux-amd64"
    sha256 "b8cd27f875f13ffce1b3dbc94d7d041fd4bbeaa6381987e3192ce910e9a9a533"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
