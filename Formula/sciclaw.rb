class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  version "0.1.48"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.48/sciclaw-darwin-arm64"
      sha256 "0d79b5967879353c989c55e90f95ef72aee3746acf4aa021b27b6f6d0196f5bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.48/sciclaw-linux-arm64"
      sha256 "01caf17ff114ab466deab301e40fedd38514d54401b23c62e1fa37b3bf7e86ac"
    end
    on_intel do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.48/sciclaw-linux-amd64"
      sha256 "36eb841f3441d8f1ef0e182071c94d00ce6401a79174feae5b2a1b08ee93b2f8"
    end
    depends_on "sciclaw-quarto"
  end

  # Source archive provides skills and workspace templates
  resource "source" do
    url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.48.tar.gz"
    sha256 "4e8c55d5d4ff3ae3ecff9157fd99268286754db08c7bef48b2ae92f6c6d7ba62"
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

  def post_install
    return unless service_definition_installed?

    unless quiet_system(bin/"sciclaw", "service", "refresh")
      opoo "sciClaw service refresh could not be applied automatically. Run: sciclaw service refresh"
    end
  end

  def service_definition_installed?
    if OS.mac?
      (Pathname.new(Dir.home)/"Library"/"LaunchAgents"/"io.sciclaw.gateway.plist").exist?
    elsif OS.linux?
      (Pathname.new(Dir.home)/".config"/"systemd"/"user"/"sciclaw-gateway.service").exist?
    else
      false
    end
  end

  def caveats
    <<~EOS
      If you use the sciClaw background gateway service, this formula attempts
      to refresh the service automatically on upgrade.

      If your environment blocks that step (no user service session), run:
        sciclaw service refresh
    EOS
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
