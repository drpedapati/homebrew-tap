class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.4.0/irl-darwin-arm64"
      sha256 "3de9e74fc005f67b36da38f4a55efa603e1899f7aabf37c2ac9df2b5061c1794"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.4.0/irl-darwin-amd64"
      sha256 "45e09b480fa0704844dd66544c19600fa3fa0c990e239ca1edc025d43b4f293c"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.4.0/irl-linux-amd64"
    sha256 "e7b335bed6e225284dc54f1a8a5851e22e900e1996bfba98d74b3e225e24f3db"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
