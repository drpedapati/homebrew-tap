class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.13/irl-darwin-arm64"
      sha256 "93a51913b409ae2a90f30aa2c2e026fb8f0e5f9e2a19ad4fc3c2b63b8bc58622"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.13/irl-darwin-amd64"
      sha256 "b51d96401e9aba52c3a521caaa7e459d6f4fb6899abc906e97c816895b1b920b"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.13/irl-linux-amd64"
    sha256 "f3c93944d79081f0c6c5c389cb2b053785689684276b8ae03ac63c03a81845ad"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
