class Socketchat < Formula
  desc "Encrypted group chat with a server you run yourself"
  homepage "https://socketchat.org"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.1/socketchat-aarch64-apple-darwin.tar.xz"
      sha256 "ecabbdd5a1b941ef1af385e12963e3ffdc3a8d2d570fb3a5e14658ad66ea36ae"
    end
    on_intel do
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.1/socketchat-x86_64-apple-darwin.tar.xz"
      sha256 "ad17a196e7cc2034c8adb3f83b8bd3a0062f0a5a008d621c3fef4ed0a60d5ee7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.1/socketchat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cd0a59b009999f5589070e03229579fea820160f8eeeea3f4ff69719703b5fe5"
    end
    on_intel do
      url "https://github.com/sachio222/socketchat/releases/download/v0.5.1/socketchat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "326f8aa217b5dfeaf0a4540074aca0de4072cb888d4e67bf215018c7df080319"
    end
  end

  def install
    bin.install "socketchat"
  end

  test do
    assert_match "socketchat #{version}", shell_output("#{bin}/socketchat --version")
  end
end
