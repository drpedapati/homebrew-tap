class SciclawPubmedCli < Formula
  desc "PubMed terminal client for search, fetch, cite, and traversal"
  homepage "https://github.com/drpedapati/pubmed-cli"
  version "0.6.0"
  version_scheme 1
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-darwin-arm64"
      sha256 "9a9151bd1d08624ca2edbc912f6850be2f0f330b938f455da67c5650b5615bad"
    end

    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-darwin-amd64"
      sha256 "677afdc21e728a3cc1a7422714916a0df0629bcbaef40278a98dd6df062f5cd3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-linux-arm64"
      sha256 "41e7f1d43a8ac4483bff4d906027c694ea418a6c6d1024cc0c0d510dbda19b1b"
    end

    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.6.0/pubmed-linux-amd64"
      sha256 "105a18a4763de1df856a7c73dc58696283de6512cf6ded91055ab16c4e3e5e5f"
    end
  end

  def install
    binary = Dir["pubmed-*"].first || "pubmed"
    bin.install binary => "pubmed"
    (bin/"pubmed-cli").make_symlink bin/"pubmed"
  end

  test do
    assert_match "Search PubMed", shell_output("#{bin}/pubmed --help")
    assert_match "Search PubMed", shell_output("#{bin}/pubmed-cli --help")
  end
end
