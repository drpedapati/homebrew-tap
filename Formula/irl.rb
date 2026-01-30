class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.5/irl-darwin-arm64"
      sha256 "5a979008ef62baf84e744eafe47cc99c2b678d3b5e120cb9b16b013cdf05c12d"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.5/irl-darwin-amd64"
      sha256 "4f4676ccfcf64384d18c8b83f81a8d9989727f1c1d5dd5545cae55dda5c7ce4a"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.5/irl-linux-amd64"
    sha256 "8c37fc99b65b45b65e2bcb4d93238bc5ee6c6adb922a7a865c52bc5f5abcbb5d"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
