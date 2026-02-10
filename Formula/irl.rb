class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.14/irl-darwin-arm64"
      sha256 "b34148f55099bf0d66324644ae04ceb258385a5e01551cfb68b46d9ec70fe8eb"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.14/irl-darwin-amd64"
      sha256 "df85929f80aa5a37cd6a4f0a5d1ca365262a0b49cd9e76ef240d69fbd1b4a5be"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.14/irl-linux-amd64"
    sha256 "5b084089af752f751f3c8eee6399735b79b4595a4db504a4bacfd363ba9759e5"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
