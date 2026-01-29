class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.4.2/irl-darwin-arm64"
      sha256 "8b5e6d851e09659193d5736889deb090028cc6b532f99a579d9412d152de1afe"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.4.2/irl-darwin-amd64"
      sha256 "3b014f7f6a2a8d3dabcec8a3fabd252c48375f2c27bdb5e0476c1eca47a1d940"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.4.2/irl-linux-amd64"
    sha256 "de12d1dec0df6e071702da586784bf5019e28ff07047348778a5b29ff6788769"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
