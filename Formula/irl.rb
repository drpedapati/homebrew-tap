class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.2.0/irl-darwin-arm64"
      sha256 "4981d537c205e5b3fd2f443addb3d8536a89fb8bade060b7e26e90a01ddd016f"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.2.0/irl-darwin-amd64"
      sha256 "0cc87416822cc4aa3ea354f52f6ae7d034c347e47cd4ca05640455942cb3d4a2"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.2.0/irl-linux-amd64"
    sha256 "409c5b12e541abbfaf122af993a39987cb4a1c073a50bdc1b1f822d951459c2b"
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
