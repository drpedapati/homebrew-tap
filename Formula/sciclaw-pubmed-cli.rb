class SciclawPubmedCli < Formula
  desc "PubMed terminal client for search, fetch, cite, and traversal"
  homepage "https://github.com/drpedapati/pubmed-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-darwin-arm64"
      sha256 "122ba342c89318f61790bca731a8b2424b350e00ab702c721b277217d7929a9d"
    end

    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-darwin-amd64"
      sha256 "5738428ed780c5185a7f043f5d5255a7f0aea09a247abb8c4f936dc765dc11e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-linux-arm64"
      sha256 "8360f26c33a6c5b5e12acdc6f7d55899dff15d5f0fc766b0632b69347b61c638"
    end

    on_intel do
      url "https://github.com/drpedapati/pubmed-cli/releases/download/v0.5.4/pubmed-linux-amd64"
      sha256 "e2c539e4c9a268f06aa3bbf1387dff923e1fdc148a0edb8f1449eadc8e63e828"
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
