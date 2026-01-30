class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.6/irl-darwin-arm64"
      sha256 "0dbe54ccf33ffda83b1c0b4e5b8156f204cd93cdc0cae2cd43fa1287e938f6dd"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.6/irl-darwin-amd64"
      sha256 "0107d530d2284ca4b48ee34bff6ce3875868a7e6b73bcb14bd1ffadb75c1c7d9"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.6/irl-linux-amd64"
    sha256 "8c9a0e483778c4f1b04876a75fee7acf3375612d52ad4f95171716944936d59b"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
