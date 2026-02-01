class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.11/irl-darwin-arm64"
      sha256 "e47344f6bb7036f850dd13d139e8357f574378ca78c9356409bda876c18ded66"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.11/irl-darwin-amd64"
      sha256 "1176f0dd3e3ec3c27bf697278a8ad70573fbde91f23d676ae03635c9fa8efcf9"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.11/irl-linux-amd64"
    sha256 "07be3655c0cbdc551db9eafc0200f1c15adfb05b5de1e61cbf705aa601983e03"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
