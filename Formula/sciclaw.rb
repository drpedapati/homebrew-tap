class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "ca48434ea138d6bb2251a8c05842ae5facbb420b3fd398134d02386b2b12cb33"
  license "MIT"
  version "0.1.8"

  depends_on "go" => :build
  depends_on "ripgrep"
  depends_on "irl"
  depends_on "docx-review"
  depends_on "pubmed-cli"

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(output: bin/"sciclaw", ldflags: ldflags), "./cmd/picoclaw"
    (bin/"picoclaw").make_symlink bin/"sciclaw"
    pkgshare.install "skills"
    (pkgshare/"templates"/"workspace").install Dir["pkg/workspacetpl/templates/workspace/*.md"]
  end

  test do
    ENV["HOME"] = testpath
    system "#{bin}/sciclaw", "onboard"
    assert_predicate testpath/".picoclaw/workspace/AGENTS.md", :exist?
    assert_match "v#{version}", shell_output("#{bin}/sciclaw --version")
  end
end
