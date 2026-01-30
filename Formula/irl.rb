class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.3/irl-darwin-arm64"
      sha256 "46a4f05b0c1b6c70367b500dd7c8f01315a903a546693aa484051e6791480832"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.3/irl-darwin-amd64"
      sha256 "ae965fadc1ca86c7982750579dced1def68835fa393453ac8e3371af40da44bf"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.3/irl-linux-amd64"
    sha256 "1ce574886f1aa3d08bb50088dcb2f385436942f8dad662e8bb6c65f901802111"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
