class Irl < Formula
  desc "CLI for creating Idempotent Research Loop (IRL) projects"
  homepage "https://github.com/drpedapati/irl-template"
  version "0.5.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.7/irl-darwin-arm64"
      sha256 "faf159acbaf3aae1722459f6d4a6b9f0d2e0a01ed88c763ca0f8fc0a9db9915d"
    else
      url "https://github.com/drpedapati/irl-template/releases/download/v0.5.7/irl-darwin-amd64"
      sha256 "bb1740ab2f053afafc74c7e744d7c485aae88b3cf3c60ca68cf3125fac5a6add"
    end
  end

  on_linux do
    url "https://github.com/drpedapati/irl-template/releases/download/v0.5.7/irl-linux-amd64"
    sha256 "5ada1fb36783b0883719c9ec35e2c3fbe044fd9635c8f01abd64fc253c913c65"
  end

  def install
    bin.install Dir["irl-*"].first => "irl"
  end

  test do
    system "#{bin}/irl", "--help"
  end
end
