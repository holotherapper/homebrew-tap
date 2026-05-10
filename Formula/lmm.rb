class Lmm < Formula
  desc "Local AI model manager for Apple Silicon"
  homepage "https://github.com/holotherapper/lmm"
  url "https://github.com/holotherapper/lmm/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "07b78629dbc06ba580b08f86044724ff1befcdc0e280fd0aa64e4d765d41177a"
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
