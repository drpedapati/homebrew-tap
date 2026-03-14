class SciclawPptxReview < Formula
  desc "Read, edit, and diff PowerPoint presentations from the CLI"
  homepage "https://github.com/drpedapati/pptx-review"
  license "MIT"
  version "1.2.0"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/pptx-review/releases/download/v1.2.0/pptx-review-darwin-arm64"
      sha256 "cdd29c20f5795dc9f7e8feead9ce5613ef14d482b9f810007cbf5dd57ab1502c"
    end

    on_intel do
      url "https://github.com/drpedapati/pptx-review/releases/download/v1.2.0/pptx-review-darwin-amd64"
      sha256 "332121492cc82e2502fcb0453da61eb143436d8f2530278b5b41d1c515445d0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/pptx-review/releases/download/v1.2.0/pptx-review-linux-arm64"
      sha256 "6ea1e6e1bd41eeb163d460a75156955c8dc4a2cd4a43f94b0b3f4b6809f66c86"
    end

    on_intel do
      url "https://github.com/drpedapati/pptx-review/releases/download/v1.2.0/pptx-review-linux-amd64"
      sha256 "3a8943cecd6e4c31426d7b6b8d02da038caf8a1b53d727ac5a3e6d54437f0d82"
    end
  end

  def install
    binary = Dir["pptx-review-*"].first || "pptx-review"
    bin.install binary => "pptx-review"
  end

  test do
    assert_match "pptx-review 1.2.0", shell_output("#{bin}/pptx-review --version")
  end
end
