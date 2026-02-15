class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "ce213d1f4acb54bdc849d1bff69fd37dbe92ae54dec62e1c0643dead1fe3aba6"
  license "MIT"
  version "0.1.9"

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
    assert_match "Usage:", shell_output("#{bin}/sciclaw --help")
    assert_match "Usage:", shell_output("#{bin}/picoclaw --help")
    assert_match "v#{version}", shell_output("#{bin}/sciclaw --version")
    assert_match "ripgrep", shell_output("#{Formula["ripgrep"].opt_bin}/rg --version")
    assert_match "irl", shell_output("#{Formula["irl"].opt_bin}/irl --version 2>&1")
    assert_match "docx-review", shell_output("#{Formula["docx-review"].opt_bin}/docx-review --version")
    assert_match "PubMed", shell_output("#{Formula["pubmed-cli"].opt_bin}/pubmed --help")
    ENV["HOME"] = testpath
    system "#{bin}/sciclaw", "onboard", "--yes"
    assert_predicate testpath/".picoclaw/workspace/AGENTS.md", :exist?
    assert_predicate testpath/".picoclaw/workspace/HOOKS.md", :exist?
    assert_predicate testpath/".picoclaw/workspace/skills/scientific-writing/SKILL.md", :exist?
  end
end
