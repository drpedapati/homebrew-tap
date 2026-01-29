class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.2.1/irl-darwin-arm64"
      sha256 "69fbd2ed8667ab355e11ab4383238fb1b53fb9d8aebf648b61211a418933fa4b"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.2.1/irl-darwin-amd64"
      sha256 "66e79893b1f09e3d7679f87ff4c0ca396ca36dbc6affa7c30436bd693ca6e57e"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.2.1/irl-linux-amd64"
    sha256 "f0a82e3011682bd6d2c84dbbae81770fb5e4aa9004324c5ca549afa97f27cda9"
  end

  def install
    binary_name = "irl-darwin-arm64"
    if OS.mac? && Hardware::CPU.intel?
      binary_name = "irl-darwin-amd64"
    elsif OS.linux?
      binary_name = "irl-linux-amd64"
    end

    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
