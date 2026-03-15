class SciclawDev < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  version "0.2.4-dev.12"
  license "MIT"

  depends_on "imagemagick"
  depends_on "irl"
  depends_on "pandoc"
  depends_on "ripgrep"
  depends_on "sciclaw-docx-review"
  depends_on "sciclaw-pptx-review"
  depends_on "sciclaw-pubmed-cli"
  depends_on "sciclaw-xlsx-review"
  depends_on "sciclaw-claude-agent"
  depends_on "uv"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.4-dev.12/sciclaw-darwin-arm64"
      sha256 "9a418365dc27bdc2400723178584a88e0d1b482a07fd2b0eff53b1ae1700f4a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.4-dev.12/sciclaw-linux-arm64"
      sha256 "a775c6709f17446ae2f0c6d3d01a5ed1fbed45c5ba87a1d9bfa89b2268bbca37"
    end
    on_intel do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.4-dev.12/sciclaw-linux-amd64"
      sha256 "76fd66efb8fe62e41a19bcf48590a25a7a496412d724174f193b8ce9398d609a"
    end
    depends_on "sciclaw-quarto"
  end

  # Source archive provides skills and workspace templates
  resource "source" do
    url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.4-dev.12/source-sciclaw-v0.2.4-dev.12-source.tar.gz"
    sha256 "9fad1f6307c5c9292dfada8cbc36f3b4fa1376c42f349a61c0de2f372a314cff"
  end

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
    assert_match "ImageMagick", shell_output("#{Formula["imagemagick"].opt_bin}/magick -version")
    assert_match "irl", shell_output("#{Formula["irl"].opt_bin}/irl --version 2>&1")
    if OS.linux?
      assert_match(/\d+\.\d+\.\d+/, shell_output("#{Formula["sciclaw-quarto"].opt_bin}/quarto --version").strip)
    end
    assert_match "docx-review", shell_output("#{Formula["sciclaw-docx-review"].opt_bin}/docx-review --version")
    assert_match "pptx-review", shell_output("#{Formula["sciclaw-pptx-review"].opt_bin}/pptx-review --version")
    assert_match "xlsx-review", shell_output("#{Formula["sciclaw-xlsx-review"].opt_bin}/xlsx-review --version")
    assert_match "PubMed", shell_output("#{Formula["sciclaw-pubmed-cli"].opt_bin}/pubmed --help")
    assert_match "stdin/stdout bridge", shell_output("#{Formula["sciclaw-claude-agent"].opt_bin}/sciclaw-claude-agent --help")
    ENV["HOME"] = testpath
    system bin/"sciclaw", "onboard", "--yes"
    assert_path_exists testpath/"sciclaw/AGENTS.md"
    assert_path_exists testpath/"sciclaw/HOOKS.md"
    assert_path_exists testpath/"sciclaw/skills/scientific-writing/SKILL.md"
  end
end
