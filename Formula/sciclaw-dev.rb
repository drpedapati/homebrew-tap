class SciclawDev < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  version "0.2.5-dev.21"
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
  depends_on "ctxclaw"
  depends_on "uv"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.5-dev.21/sciclaw-darwin-arm64"
      sha256 "9eedbd978eac853f7470faeea7deac7ee385386c2943b6cd2d4615284c51f284"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.5-dev.21/sciclaw-linux-arm64"
      sha256 "281213f8c7b03272fb322e63639a8977b08cc04732e1b1640b47df3b9fc3ddab"
    end
    on_intel do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.5-dev.21/sciclaw-linux-amd64"
      sha256 "f41b52cba8caa3e64d380f376d6be2c84cbbe8a33abfa384e7e1cdaca1de4e44"
    end
    depends_on "sciclaw-quarto"
  end

  resource "source" do
    url "https://github.com/drpedapati/sciclaw/releases/download/v0.2.5-dev.21/source-sciclaw-v0.2.5-dev.21-source.tar.gz"
    sha256 "c0ab5b7193e573b3d91e369d36e8288f6ead7e9d435fcd0c41bf7c2428d0d364"
  end

  def install
    if OS.mac?
      bin.install "sciclaw-darwin-arm64" => "sciclaw"
    elsif OS.linux? && Hardware::CPU.arm?
      bin.install "sciclaw-linux-arm64" => "sciclaw"
    else
      bin.install "sciclaw-linux-amd64" => "sciclaw"
    end
    (bin/"picoclaw").make_symlink bin/"sciclaw"

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
    assert_match "ctxclaw", shell_output("#{Formula["ctxclaw"].opt_bin}/ctxclaw version")
    ENV["HOME"] = testpath
    system bin/"sciclaw", "onboard", "--yes"
    assert_path_exists testpath/"sciclaw/AGENTS.md"
    assert_path_exists testpath/"sciclaw/HOOKS.md"
    assert_path_exists testpath/"sciclaw/skills/scientific-writing/SKILL.md"
  end
end
