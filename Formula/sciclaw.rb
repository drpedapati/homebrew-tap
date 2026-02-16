class Sciclaw < Formula
  desc "Autonomous paired scientist CLI forked from PicoClaw"
  homepage "https://github.com/drpedapati/sciclaw"
  license "MIT"

  source_url = "https://github.com/drpedapati/sciclaw/archive/refs/tags/v0.1.26.tar.gz"
  source_sha256 = "241d2b7b8eca9ed54200a26ed409b67b9ced362b051b086ad4a56d2e9eda75ee"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.26/sciclaw-darwin-arm64"
      sha256 "58dbfa81c456b98b94b94980361fdb5ce1911acf65b09d8f20ea352a1d09f3da"
    else
      url source_url
      sha256 source_sha256
      depends_on "go" => :build
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.26/sciclaw-linux-amd64"
      sha256 "852815a8cad3df7626c19a40ef3d23f0c1abe4d3066120e150dcbefbbc6ea617"
    elsif Hardware::CPU.arm?
      url "https://github.com/drpedapati/sciclaw/releases/download/v0.1.26/sciclaw-linux-arm64"
      sha256 "1e5233b288afbaaa316be71e2434fbe588debfb80c5b54a524e049dd0f4a1600"
    else
      url source_url
      sha256 source_sha256
      depends_on "go" => :build
      depends_on "gcc" => :build
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
