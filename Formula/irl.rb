class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.12/irl-darwin-arm64"
      sha256 "c48ed83d4a8126eb9c19024c862799225002a0ac373fb36a73855001b041376f"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.12/irl-darwin-amd64"
      sha256 "fa6e6204c3dd63d75ea46a7a3ddff9c70a82ea252d0b0acf9c57c0b0726e3ad3"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.12/irl-linux-amd64"
    sha256 "6f64a5e375c1b4d256b06c1181b3d8e52dae130b45e3ddfbb9681ee5327030c1"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
