class SciclawDocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.5.0"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-darwin-arm64"
      sha256 "19f574eefcd02d3160982f9aa3d9472d81e92b95f8055150ade89b6d6f1d7da9"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-darwin-amd64"
      sha256 "7ea25c4be73a27e3a39a88abcfe6ad470041f598c0f85df86e62b7d2a0565240"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-linux-arm64"
      sha256 "f1479f2b3db4ab5dea8d975ff08895a6086acdc2ca78923b1bcca43b8bfcd8ce"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.0/docx-review-linux-amd64"
      sha256 "b99f40b283e159fe05ccfa682826aa0b017c9e471f8bb658e8822fcc86616d19"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.5.0", shell_output("#{bin}/docx-review --version")
  end
end
