class DocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.3.4"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.4/docx-review-darwin-arm64"
      sha256 "32e63553f4ef44198b70ac25b67fec9e012f530d609e77e5e0b8c68e39ffc911"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.4/docx-review-darwin-amd64"
      sha256 "14ec9d4363f334f650d8b5dc03ae795cc02ad99dd579e986d45d176839086046"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.4/docx-review-linux-arm64"
      sha256 "3270903d178b9eabfeec0d872d35ff1f3b6616560ed411558a860185492c9e14"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.3.4/docx-review-linux-amd64"
      sha256 "94fef870233f7806b73911b0ae0c69a4326aafc73009ec70428cdb8a0675dc4a"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.3.4", shell_output("#{bin}/docx-review --version")
  end
end
