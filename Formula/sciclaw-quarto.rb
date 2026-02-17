class SciclawQuarto < Formula
  desc "Quarto CLI for scientific and technical publishing"
  homepage "https://quarto.org"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.27/quarto-1.8.27-macos.tar.gz"
      sha256 "d29d163d933e07aa55ae0cea1bc5ce21cbf2bd2b544950336f9d752eba0cda1d"
    end

    on_intel do
      url "https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.27/quarto-1.8.27-macos.tar.gz"
      sha256 "d29d163d933e07aa55ae0cea1bc5ce21cbf2bd2b544950336f9d752eba0cda1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.27/quarto-1.8.27-linux-arm64.tar.gz"
      sha256 "1f2082e82e971c5b2b78424cac93a0921c0050455ec5eaa32533b0230682883e"
    end

    on_intel do
      url "https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.27/quarto-1.8.27-linux-amd64.tar.gz"
      sha256 "bdf689b5589789a1f21d89c3b83d78ed02a97914dd702e617294f2cc1ea7387d"
    end
  end

  # On macOS, users typically install Quarto via the official Homebrew cask (`brew install --cask quarto`).
  conflicts_with cask: "quarto", because: "both install the `quarto` executable"

  def install
    # Preserve upstream layout so the `bin/quarto` launcher can find `share/`.
    if (buildpath/"bin/quarto").exist?
      prefix.install "bin", "share"
      return
    end

    # Linux archives are expected to include a top-level directory (often `quarto-<ver>`),
    # but don't assume a specific folder name: locate the launcher and derive the root.
    quarto_bin = Dir["**/bin/quarto"].first
    odie "quarto launcher not found in archive; expected **/bin/quarto" unless quarto_bin
    root = dirname(quarto_bin, 2)
    odie "quarto share/ not found next to #{root}/bin" unless (buildpath/"#{root}/share").exist?
    prefix.install "#{root}/bin", "#{root}/share"
  end

  test do
    assert_match "1.8.27", shell_output("#{bin}/quarto --version").strip
  end
end
