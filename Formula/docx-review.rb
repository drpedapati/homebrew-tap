class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.4.0"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-darwin-arm64"
      sha256 "00575211e8f2d04a7c39457fcc687153b3f2e81d6f91723c01cd04f3ec5f9d04"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-darwin-amd64"
      sha256 "324b083a646652868cf95230dec3e49ac2cb736d0ea01b05f8c925cbb1a95a15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-linux-arm64"
      sha256 "4577b4741cf29cec10a03c3df8292e06419eef00059b71d57c8610aee1220fb6"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-linux-amd64"
      sha256 "c99b10a42b4e72fb8cd6772575eb2ef2302dc25b9e99e8248506238b27e53744"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.4.0", shell_output("#{bin}/docx-review --version")
  end
end
