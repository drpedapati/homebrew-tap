class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  license "MIT"
  version "0.1.27"

  source_url = "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.27.tar.gz"
  source_sha256 = "0c8fc063570d30fd132ec455261d1d9b9065e6f38c8dfc82fc3b7f7c19a7b4f9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.27/sciclaw-darwin-arm64"
      sha256 "0c4088a40a24e3c00b9189284d21e1fabace919bbd0dc0d9896981b0dfa56ba0"
    else
      url source_url
      sha256 source_sha256
      depends_on "go" => :build
    end
  end

  on_linux do
    depends_on "gcc" => :build

    if Hardware::CPU.intel?
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.27/sciclaw-linux-amd64"
      sha256 "98a6c634a4b93cfb4ad58bad33b4ae707e92ede2f44dacd2632c03047894f4eb"
    elsif Hardware::CPU.arm?
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.27/sciclaw-linux-arm64"
      sha256 "275b0bc55989652a84ddf420f375ad9b8d8666ee97eff71b9245c496f6e68adb"
    else
      url source_url
      sha256 source_sha256
      depends_on "go" => :build
    end

    depends_on "sciclaw-quarto"
  end

  depends_on "irl"
  depends_on "ripgrep"
  depends_on "sciclaw-docx-review"
  depends_on "sciclaw-pubmed-cli"

  resource "sciclaw-source" do
    url source_url
    sha256 source_sha256
  end

  def install
    if (buildpath/"cmd/picoclaw").exist?
      ldflags = "-s -w -X main.version=#{version}"
      system "go", "build", *std_go_args(output: bin/"sciclaw", ldflags: ldflags), "./cmd/picoclaw"
    else
      binary = Dir["sciclaw-*"].first
      odie "prebuilt sciclaw binary not found in downloaded artifact" unless binary
      bin.install binary => "sciclaw"
    end
    (bin/"picoclaw").make_symlink bin/"sciclaw"

    if (buildpath/"skills").exist?
      pkgshare.install "skills"
      (pkgshare/"templates"/"workspace").install Dir["pkg/workspacetpl/templates/workspace/*.md"]
    else
      resource("sciclaw-source").stage do
        pkgshare.install "skills"
        (pkgshare/"templates"/"workspace").install Dir["pkg/workspacetpl/templates/workspace/*.md"]
      end
    end
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
