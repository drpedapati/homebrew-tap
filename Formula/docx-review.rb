class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.4.0"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-darwin-arm64"
      sha256 "09406a71ff8763c63146747b68ace6af70a52a4d4f7b81246c6cb6b214cc0876"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-darwin-amd64"
      sha256 "3d6f187f12067fd2ebc75e1a3ca0f6497756d51c3847009e8dd347661fb63e73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-linux-arm64"
      sha256 "b4e8bda6d2fd0cea4ccced139792a36a43031cd830fd59735523a4af08737247"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.0/docx-review-linux-amd64"
      sha256 "5003fa3d2a79b5cdf3c4871d9b4f5c3a928539222351c86ff6e536993d242b6c"
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
