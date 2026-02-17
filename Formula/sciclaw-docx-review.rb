class SciclawDocxReview < Formula
  desc "Read, edit, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.2.0/docx-review-darwin-arm64"
      sha256 "bc1ec34d6100cd61c489c6346c6f2cd04356b448605219ae7065e8991cfbac3e"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.2.0/docx-review-darwin-amd64"
      sha256 "e52d57da11b01fb7237ba80c8ee1eff3ac37e3b5e593a11960b9e350b03124f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.2.0/docx-review-linux-arm64"
      sha256 "2f85ddc59514aab411332c17b051d0e9e4ec8878d8b74e09e8e1918052281dcc"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.2.0/docx-review-linux-amd64"
      sha256 "8894e790fc69eb6e8311e2f90d0279f344b598535168da59d27af0595c884b66"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.2.0", shell_output("#{bin}/docx-review --version")
  end
end
