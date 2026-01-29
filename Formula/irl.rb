class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.2/irl-darwin-arm64"
      sha256 "2a1ac66d868cbf741977916fec9ccf1b4729ad98c89840d840902c989c7d62e8"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.2/irl-darwin-amd64"
      sha256 "b2074b5c3fbf692e711147d52e2c9fd2c1e2445bb0761c4a1d9552144ee1a100"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.3.2/irl-linux-amd64"
    sha256 "04d8a393db815619057e6c627c7e6a10eb8368947a63980037e80ce7bf95b983"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
