class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.0/irl-darwin-arm64"
      sha256 "74ccdf324536424e72a2ecbfdfd2e363b885ce49ef012ede41d92ae1640fc1b3"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.0/irl-darwin-amd64"
      sha256 "8a2a04450a495e8df10daf16d67bdce23724d598c4508f43ff98605804805e90"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.0/irl-linux-amd64"
    sha256 "acb4b04e35010dd76fd32b5f74644ce529d01c7a55685da71454a932ad8f4fa0"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
