class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.0/irl-darwin-arm64"
      sha256 "f0ba6760fa09b072355fbd06ac8f8599ab4f3406bc2671d276d23446591b2087"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.3.0/irl-darwin-amd64"
      sha256 "7f9e06bb4d0f058a1fd8302b4b7ef96250a61b2b0bc13c74fff6a962442bf0c6"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.3.0/irl-linux-amd64"
    sha256 "fb9bfdabd168dcac51c44f359a97c48b7db871a8526ab8af0288a2d790537ac8"
  end

  def install
    binary_name = "irl-darwin-arm64"
    if OS.mac? && Hardware::CPU.intel?
      binary_name = "irl-darwin-amd64"
    elsif OS.linux?
      binary_name = "irl-linux-amd64"
    end

    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
