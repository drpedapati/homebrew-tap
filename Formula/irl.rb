class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.17/irl-darwin-arm64"
      sha256 "6439931b5bde4264a6193587b36095ab464aeffed66e99845b8a3cdd2842c6f7"
    end

    on_intel do
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.17/irl-darwin-amd64"
      sha256 "829d8d92dddd6b3d0245c45060f276496220bc3a37c618c9292d25433b0e7fc5"
    end
  end

  on_linux do
    on_arm do
      url "https://api.github.com/repos/drpedapati/irl-template/tarball/v0.5.17"
      sha256 "f73fe2be621197a23f559e3bd5f6bd0b56ab4001f757f6924552895d7c801be5"
      depends_on "go" => :build
    end

    on_intel do
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.17/irl-linux-amd64"
      sha256 "3cd4ceda734027d77ba8bde1d8413848f498cf41ca3d59ee4b491eade5dcd98a"
    end
  end

  def install
    # Build from source on Linux ARM where no upstream release binary is available.
    if OS.linux? && Hardware::CPU.arm?
      ldflags = "-s -w -X main.version=#{version}"
      system "go", "build", *std_go_args(output: bin/"irl", ldflags: ldflags), "."
      return
    end

    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system bin/"irl", "--help"
  end
end
