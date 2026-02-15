class PubmedCli < Formula
  desc "PubMed from your terminal — search, fetch, cite, traverse. Built for humans and AI agents."
  homepage "https://github.com/drpedapati/pubmed-cli"
  url "https://github.com/drpedapati/pubmed-cli/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "3eea9ae9f598c37b940c95dc34a390681245e9672a89d6466a69824c40c93c09"
  license "MIT"
  version "0.5.3"

  depends_on "go" => :build

  def install
    ldflags = "-s -w"
    system "go", "build", *std_go_args(output: bin/"pubmed", ldflags: ldflags), "./cmd/pubmed"
    (bin/"pubmed-cli").make_symlink bin/"pubmed"
  end

  test do
    assert_match "Search PubMed", shell_output("#{bin}/pubmed --help")
    assert_match "Search PubMed", shell_output("#{bin}/pubmed-cli --help")
  end
end

