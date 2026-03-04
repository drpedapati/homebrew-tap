class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.3.5"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.5/docx-review-darwin-arm64"
      sha256 "afcf1837a46ad2615c70ead880cf6dff5b45a4e0bc9bde161fbee2330ab65fc1"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.5/docx-review-darwin-amd64"
      sha256 "5168cc607ca183878b2cfcb9d295c7700317ecde084893a939dd4ef6a990e585"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.5/docx-review-linux-arm64"
      sha256 "5383884269bbe3dc2a2d6982becc0d44f6c49fddd988b0a7053f2e8296c96ebb"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.5/docx-review-linux-amd64"
      sha256 "3917d6523366c3535c481f6ee8cb876de97c36b496ffe85646cb77c75aa4caef"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.5", shell_output("#{bin}/docx-review --version")
  end
end
