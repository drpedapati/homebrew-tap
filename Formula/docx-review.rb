class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.4.2"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.2/docx-review-darwin-arm64"
      sha256 "8687929e2be0d927c0b2bea32eac12d8407b236b9ec002e74e4023628011429a"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.2/docx-review-darwin-amd64"
      sha256 "0dee8acda5e2febd4107ec157c9ca4670ef9a79f1a14a2f6c98bb9b8516f615e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.2/docx-review-linux-arm64"
      sha256 "b05bf72ebc202218ba06238c10552a2a922c6f462c769552338b3c83643e4080"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.4.2/docx-review-linux-amd64"
      sha256 "bdf6f01bd53ec3efa07f15ef3b509c29caf4e662984965c35cd04c9a3ccbf42d"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.4.2", shell_output("#{bin}/docx-review --version")
  end
end
