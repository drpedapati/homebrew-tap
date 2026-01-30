class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.2/irl-darwin-arm64"
      sha256 "228c3b4c67ef86f3ff8d4ead8cafbc25573ca69825349ac8257f502d9e461f2f"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.2/irl-darwin-amd64"
      sha256 "4e4951732a4ee68d0dfff70ce91f66e012b1ecb39f6a47c0d51f32ebfea2f282"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.2/irl-linux-amd64"
    sha256 "4e3912b4c8b9a164696c231a76a986a06aede4983bcf06666690043c0d276375"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
