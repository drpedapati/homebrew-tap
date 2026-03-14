class SciclawXlsxReview < Formula
  desc "Read, edit, and diff Excel spreadsheets from the CLI"
  homepage "https://github.com/drpedapati/xlsx-review"
  license "MIT"
  version "1.2.1"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-darwin-arm64"
      sha256 "dd4f6d2b9332ebf3322fd8f0a4e2a9319ef0d8ec68f0f23824b3152edf174e0e"
    end

    on_intel do
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-darwin-amd64"
      sha256 "5982f72d4badb1a75d99525462e3dd68b0562476f91be6bd8499a273ea464d72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-linux-arm64"
      sha256 "65aba4dd924156e60fdbceeffd76575f0d9703da110221a62a1c36c62d6913c7"
    end

    on_intel do
      url "https://github.com/drpedapati/xlsx-review/releases/download/v1.2.1/xlsx-review-linux-amd64"
      sha256 "d1655f610b4f43276fc1b0855236880b3ed7f36635c908f82eafaac1e0e1b983"
    end
  end

  def install
    binary = Dir["xlsx-review-*"].first || "xlsx-review"
    bin.install binary => "xlsx-review"
  end

  test do
    assert_match "xlsx-review 1.2.1", shell_output("#{bin}/xlsx-review --version")
  end
end
