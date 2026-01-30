class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.4/irl-darwin-arm64"
      sha256 "120f365f22e080a424e99123381b45a4e64892611dcd52627b2da75a6709008f"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.4/irl-darwin-amd64"
      sha256 "83bda2e0d346135ce76d64c9d4b70d45e80d5cf91e03a0fe6ffd6e71e3f99749"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.4/irl-linux-amd64"
    sha256 "113072a24837ea7f43bc90968dd63f006e6a9069cee871bf4e4f5381bf37c9cf"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
