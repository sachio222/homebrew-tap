class Socketchat < Formula
  desc "Encrypted group chat with a server you run yourself"
  homepage "https://socketchat.org"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.1/socketchat-aarch64-apple-darwin.tar.xz"
      sha256 "5e328c1013e66a3110cf193a44afbca91b2caaadb66caf1e0ec34634d4d8cc30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.1/socketchat-x86_64-apple-darwin.tar.xz"
      sha256 "fb07e99f98dbdfc908e22cf7ce41ed10b9c11ed57074c9f44c5781e0eead2070"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.1/socketchat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "be33a8da3da2354c97c5508a893671a1f91c18dc5f53b2f84676fd2e1dce7e56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sachio222/socketchat/releases/download/v0.6.1/socketchat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3e0480cc44d4c7a9f4f7eb63b982eb3a45d43e90f1e4b45582730613585bdcfb"
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
