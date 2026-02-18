class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  version "0.1.38"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.38/sciclaw-darwin-arm64"
      sha256 "6ab47043064745b393d1366ef053723476c40fd7298d839a8ea94ad863c71848"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.38/sciclaw-linux-arm64"
      sha256 "bcb43ab362d59f00876bb7dbbfdf9214ecb63c4093210d2360c60da360704ff6"
    end
    on_intel do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.38/sciclaw-linux-amd64"
      sha256 "814f5c55773407cd3cc78b47316239d773d4e89dcc2137456471fad934a71363"
    end
    depends_on "sciclaw-quarto"
  end

  # Source archive provides skills and workspace templates
  resource "source" do
    url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.38.tar.gz"
    sha256 "4ff33616e470a79e391f35ef8ae2a5f45dd4daa343d83edcbba52d732e796913"
  end

  depends_on "irl"
  depends_on "pandoc"
  depends_on "ripgrep"
  depends_on "sciclaw-docx-review"
  depends_on "sciclaw-pubmed-cli"

  def install
    # Install pre-compiled binary
    if OS.mac?
      bin.install "sciclaw-darwin-arm64" => "sciclaw"
    elsif OS.linux? && Hardware::CPU.arm?
      bin.install "sciclaw-linux-arm64" => "sciclaw"
    else
      bin.install "sciclaw-linux-amd64" => "sciclaw"
    end
    (bin/"picoclaw").make_symlink bin/"sciclaw"

    # Install skills and workspace templates from source
    resource("source").stage do
      pkgshare.install "skills"
      (pkgshare/"templates"/"workspace").install Dir["pkg/workspacetpl/templates/workspace/*.md"]
    end
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/sciclaw 2>&1", 1)
    assert_match "Usage:", shell_output("#{bin}/picoclaw 2>&1", 1)
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
