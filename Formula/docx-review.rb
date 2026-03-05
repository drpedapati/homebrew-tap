class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.4.1"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.1/docx-review-darwin-arm64"
      sha256 "4c0852fff3520ca9db089557940650ef71f6e8b6d770831ecfb920372a2ece91"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.1/docx-review-darwin-amd64"
      sha256 "0dee8acda5e2febd4107ec157c9ca4670ef9a79f1a14a2f6c98bb9b8516f615e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.1/docx-review-linux-arm64"
      sha256 "1af2489cfc6a397a6463a6c79d92b430052852d54716146030931a2323a94a3d"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.1/docx-review-linux-amd64"
      sha256 "bdf6f01bd53ec3efa07f15ef3b509c29caf4e662984965c35cd04c9a3ccbf42d"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.4.1", shell_output("#{bin}/docx-review --version")
  end
end
