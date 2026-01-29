class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.4.1/irl-darwin-arm64"
      sha256 "269e6455609417f7cfb5631aea9d88e26b7ae943763e6149222eea13e87b6931"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.4.1/irl-darwin-amd64"
      sha256 "e67e54644e5d013dea02205714209271e8566eb35d4da22e2049b72ab3fb4a63"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.4.1/irl-linux-amd64"
    sha256 "1c7965e22f5a882c0c15d8538d7203239c79a64d52f9cb1e5002ac33f5a026e6"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
