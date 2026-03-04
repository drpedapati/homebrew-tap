class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.3.3"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.3/docx-review-darwin-arm64"
      sha256 "057ad89568a2613a82045dc8c9bb8a0177834b2da2cc67ca2be1323f22858abc"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.3/docx-review-darwin-amd64"
      sha256 "0c105df1f801dc26fc714d1f16292cd58cf8b67e9bdff9042828d721ec05e0e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.3/docx-review-linux-arm64"
      sha256 "5682ef7cd66ddad40cfe8b9dec7bbd247875d0f8d6deaeb0862fffbbfe0acdb3"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.3/docx-review-linux-amd64"
      sha256 "4f4f4e96bf44078fe37e648a223451175a96c3dff610c77ac19a2f43d091839e"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.3", shell_output("#{bin}/docx-review --version")
  end
end
