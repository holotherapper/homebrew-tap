class Lmm < Formula
  desc "Local AI model manager for Apple Silicon"
  homepage "https://github.com/holotherapper/lmm"
  url "https://github.com/holotherapper/lmm/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "82ca8da7ff5fa5925b5e284510291aa16bfe66833f528a89260585520545560e"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def post_install
    cargo_bin = Pathname.new(Dir.home).join(".cargo/bin/lmm")
    local_bin = Pathname.new(Dir.home).join(".local/bin/lmm")
    [cargo_bin, local_bin].each do |shadow|
      next unless shadow.exist?
      opoo "#{shadow} shadows the Homebrew-installed lmm."
      ohai "Remove it with: rm #{shadow}"
    end
  end

  test do
    assert_match "lmm", shell_output("#{bin}/lmm --version")
  end
end
