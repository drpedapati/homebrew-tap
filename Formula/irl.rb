class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.1/irl-darwin-arm64"
      sha256 "24e554298e0a5f0d8ae31b3bc9ac71db9500d1b880130c94549f4f2373b036f0"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.1/irl-darwin-amd64"
      sha256 "26267a3a1c7f656504662971585fbd999f646d69227be5fad71825fd42a6a16e"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.1/irl-linux-amd64"
    sha256 "0472737b9aa2866b6ec4da5ee5b78cbe2ad1da4090542f726f61cbda2c30fe32"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
