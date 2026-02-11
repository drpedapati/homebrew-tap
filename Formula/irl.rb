class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.16/irl-darwin-arm64"
      sha256 "2e1ccd9ab77d281184830af2372c72d6c70bdc4c6422b6d42eed0038b0dfecd9"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.16/irl-darwin-amd64"
      sha256 "a4098d0b279c13a9678037c385475481fe92ec96632ace6f12d73f448cd7dbc9"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.16/irl-linux-amd64"
    sha256 "cd731888bce53740916c119d4227450b1d13fa69fd19c9df5ec957269bae224b"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
