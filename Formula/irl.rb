class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.15"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.15/irl-darwin-arm64"
      sha256 "9150414a044cb96b4ee8458f70de6b1b18fd50085a139a649f95d26466e4a735"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.15/irl-darwin-amd64"
      sha256 "db7371adacbea1841ed4fcac0fae9e646c5990ec534525ef817d6049fb233275"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.15/irl-linux-amd64"
    sha256 "9087a1f8ee0135ced19c0e3d3556916449e55d149459e1501e7611a4448a14c4"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
