class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.9/irl-darwin-arm64"
      sha256 "112de40122080344beb1d2018455018d0f757d3e39fb587462f19a005c2c1b6c"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.9/irl-darwin-amd64"
      sha256 "17f53dee62a09d63c209deeab9a23f58a3ffa326947e6ee493cf5fbaa11e0770"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.9/irl-linux-amd64"
    sha256 "172fbde0d40e0c100d0d56695b6e1344c05788ce53e3c0374a742331f42155c7"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
