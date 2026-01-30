class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.8/irl-darwin-arm64"
      sha256 "4a2bb2ba7ce6c51ddc2a3c00e4a084f05a04ca8bd3c81fa7c21775826c92473a"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.8/irl-darwin-amd64"
      sha256 "b0831870feec744c120b8644f2919f1cc4ed9bb53f9fdfd7b1d9a8602a277e93"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.8/irl-linux-amd64"
    sha256 "b9574c1f3f4fbd3ed72372170634da026f27dfc918ddd72c099efd68b32ed6be"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
