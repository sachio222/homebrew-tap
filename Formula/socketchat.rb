class Socketchat < Formula
  desc "Encrypted group chat with a server you run yourself"
  homepage "https://socketchat.org"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.0/socketchat-aarch64-apple-darwin.tar.xz"
      sha256 "710c1df09ab7161105c3ee49216277f00b7435d0432e1cf7e635bbf9ded51033"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.0/socketchat-x86_64-apple-darwin.tar.xz"
      sha256 "19946c27035b270fb0a0333abf5839cb604bb756bba2af95c0b0a2b54f01a35d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.0/socketchat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea48be74f6de8d161554107eeb0b4f7a2649c9a7492ce37051b27a325f8a0dc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.0/socketchat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2dd65d9023f8b378b6c7262102634c6f72249a9ea9b725060e27bb16fc1b5060"
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
