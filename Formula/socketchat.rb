class Socketchat < Formula
  desc "Encrypted group chat with a server you run yourself"
  homepage "https://socketchat.org"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.2/socketchat-aarch64-apple-darwin.tar.xz"
      sha256 "9ddad1d09bd0629cfb9d2b1ded3eddb8a5fb412fd105ee6eebe5f6a22b253716"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.2/socketchat-x86_64-apple-darwin.tar.xz"
      sha256 "42e64440ec75e9fccec2afe66ef9fe8396472b7e82d22474c14fa5102a43d415"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.2/socketchat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "35848766a33ecc6baf8dbd6d66830db821318b1be090b8e0b92335bc76ffaf99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.2/socketchat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1fa3c70802e562094eba1dd93f651250141a1d0fdb29013e8aeed5b442425072"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "socketchat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "socketchat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "socketchat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "socketchat"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match "socketchat #{version}", shell_output("#{bin}/socketchat --version")
  end
end
