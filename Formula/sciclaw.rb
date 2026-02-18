class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  version "0.1.42"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.42/sciclaw-darwin-arm64"
      sha256 "4bf61e65c1f2272736e26baaf277eb43253e90f94cd7c0ff53c04887b7f32712"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.42/sciclaw-linux-arm64"
      sha256 "48509734ac590515bc06c735fe8af26906a774fde3091cf8b98a2b861e18774f"
    end
    on_intel do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.42/sciclaw-linux-amd64"
      sha256 "5947f6024d6547a7a91641ec6b4390bc04d9788c165e9e52c91100babf1d4417"
    end
    depends_on "sciclaw-quarto"
  end

  # Source archive provides skills and workspace templates
  resource "source" do
    url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.42.tar.gz"
    sha256 "2e3d7f7da786372d45dd8772840b086da10a6153f776f0e2ba408a35449d1a2f"
  end

  depends_on "irl"
  depends_on "pandoc"
  depends_on "ripgrep"
  depends_on "uv"
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
