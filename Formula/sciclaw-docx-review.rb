class SciclawDocxReview < Formula
  desc "Read, edit, create, and diff Word documents with tracked changes from the CLI"
  homepage "https://github.com/drpedapati/docx-review"
  version "1.5.1"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.1/docx-review-darwin-arm64"
      sha256 "82004791c4a4c511e85afd03a1423bc9638dbdebb3f69da312f9181d9180aaff"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.1/docx-review-darwin-amd64"
      sha256 "e24d9c11575ffa48ed25fcfc69f8302a7382feb4e797ec906ca5894516b68378"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.1/docx-review-linux-arm64"
      sha256 "f851d5aab6c1e6d9f1062121f315d0b26c70f8ea98e56ad1a1a58641b05419e4"
    end

    on_intel do
      url "https://github.com/drpedapati/docx-review/releases/download/v1.5.1/docx-review-linux-amd64"
      sha256 "a85d9f3d7a8d38b392c17a300d99e18f742dcba9b7b4f6aa63baf606100d2a15"
    end
  end

  def install
    binary = Dir["docx-review-*"].first || "docx-review"
    bin.install binary => "docx-review"
  end

  test do
    assert_match "docx-review 1.5.1", shell_output("#{bin}/docx-review --version")
  end
end
