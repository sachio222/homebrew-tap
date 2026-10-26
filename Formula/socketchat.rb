class Socketchat < Formula
  desc "Encrypted group chat with a server you run yourself"
  homepage "https://socketchat.org"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.2/socketchat-aarch64-apple-darwin.tar.xz"
      sha256 "5fdfdb6b5d277fd82926f573e88ca92ce630a4b6421a97fc949f103568c91fc2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.2/socketchat-x86_64-apple-darwin.tar.xz"
      sha256 "88baa8a9010c442350514e599f38927776ce84cdc9ac9545e470b17a83a7f3aa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.2/socketchat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e608a80176e43e567f0fc51a14b0e5527a19ab78d7c4b172881ab40a0d8e6ee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.2/socketchat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba61f293cdfbcdb5fb82656b0de0afc062bddece488c6c0bf0f56bec5027cedb"
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
