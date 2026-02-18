class SciclawDocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-darwin-arm64"
      sha256 "37fe2ad83660696ba4ece56bbedd39e01ca2a3fa51ad01af853bc308de401609"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-darwin-amd64"
      sha256 "b06a569ad84a1f2a88e7e0424679cdac9f0f2de96d7420beb878c20de06741b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-linux-arm64"
      sha256 "3f49741164a040bcb5b8e09e062a4d7f6088ef7b611d31754f751314e6db3aca"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.0/docx-review-linux-amd64"
      sha256 "2f088bcdfb0d152988960a8a08fb513fc7912a522c8c7afa6d8b0c7c2e4d063f"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.0", shell_output("#{bin}/docx-review --version")
  end
end
