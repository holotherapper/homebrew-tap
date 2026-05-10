class Lmm < Formula
  desc "Local AI model manager for Apple Silicon"
  homepage "https://github.com/holotherapper/lmm"
  url "https://github.com/holotherapper/lmm/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "6fdcae3b585f4adb7b11b2ecb0c3db1dd09d80cca73fe6e062e9d01e18f7468c"
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
