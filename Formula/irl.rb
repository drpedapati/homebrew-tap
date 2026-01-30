class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.10/irl-darwin-arm64"
      sha256 "8cbeda19a3ccbb12680da17d623123cec65f4fe4d8990d4a5c51def8167437c3"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.10/irl-darwin-amd64"
      sha256 "36cb41d47a196f0d0258eedbc2862c2b694a2e1c14464fc8520bd7ce04f1cb09"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.10/irl-linux-amd64"
    sha256 "ec64b9d348640aa8c9b5337a25962e2f622f50a370d72a6f08255a91204b78b8"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
