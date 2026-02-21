class SciclawDev < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  version "0.1.53-dev.8"
  license "MIT"

  depends_on "imagemagick"
  depends_on "irl"
  depends_on "pandoc"
  depends_on "ripgrep"
  depends_on "sciclaw-docx-review"
  depends_on "sciclaw-pubmed-cli"
  depends_on "uv"

  on_macos do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.53-dev.8/sciclaw-darwin-arm64"
      sha256 "211f68c93775878aee48f3801fb2ff80e0334e38a6f5305468b99bd40cbe94c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.53-dev.8/sciclaw-linux-arm64"
      sha256 "f339b9516ce1bd8e63e1d323f877e1b537005e99236af7354f9198b3598b171d"
    end
    on_intel do
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.53-dev.8/sciclaw-linux-amd64"
      sha256 "071a1e75eff6acf8ca86430263a6842dc2aa787a3b48ede394d62e3ec72da28c"
    end
    depends_on "sciclaw-quarto"
  end

  # Source archive provides skills and workspace templates
  resource "source" do
    url "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.53-dev.8.tar.gz"
    sha256 "bf940d6aabcfc834bf7c31445ca77f3cbf8acfa9a8208335b9382a63e4fe5c09"
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
    assert_match "PubMed", shell_output("#{Formula["sciclaw-pubmed-cli"].opt_bin}/pubmed --help")
    ENV["HOME"] = testpath
    system bin/"sciclaw", "onboard", "--yes"
    assert_path_exists testpath/"sciclaw/AGENTS.md"
    assert_path_exists testpath/"sciclaw/HOOKS.md"
    assert_path_exists testpath/"sciclaw/skills/scientific-writing/SKILL.md"
  end
end
