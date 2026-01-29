class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.1/irl-darwin-arm64"
      sha256 "048dd94891288005b902fcea9d401d7dad20bfbc1ca6def8fa1ea1cb94d20767"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.1/irl-darwin-amd64"
      sha256 "2c7c3ad438f0348b9132e4eaaa5990331cafdfbe161e52821d9dcb6eb61bd5df"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.3.1/irl-linux-amd64"
    sha256 "c6e94bf58ebbfcd31a7d80c1bb9dc297932f761edbf65fe08c814185ba5ae115"
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
