class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.19.tar.gz"
  sha256 "5996bb79b5fc77fc4ade6a955c6da9d5a32a5eb50c0e5bdd755ed3cdbc0550d4"
  license "MIT"

  depends_on "go" => :build
  depends_on "irl"
  depends_on "ripgrep"
  depends_on "sciclaw-docx-review"
  depends_on "sciclaw-pubmed-cli"

  on_linux do
    depends_on "sciclaw-quarto"
  end

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
    if OS.linux?
      assert_match(/\d+\.\d+\.\d+/, shell_output("#{Formula["sciclaw-quarto"].opt_bin}/quarto --version").strip)
    end
    assert_match "docx-review", shell_output("#{Formula["sciclaw-docx-review"].opt_bin}/docx-review --version")
    assert_match "PubMed", shell_output("#{Formula["sciclaw-pubmed-cli"].opt_bin}/pubmed --help")
    ENV["HOME"] = testpath
    system bin/"sciclaw", "onboard", "--yes"
    assert_path_exists testpath/"sciclaw/AGENTS.md"
    assert_path_exists testpath/"sciclaw/HOOKS.md"
    assert_path_exists testpath/"sciclaw/skills/scientific-writing/SKILL.md"
  end
end
