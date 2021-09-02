class Singularity < Formula
  desc "Application containers for Linux"
  homepage "https://singularity.hpcng.org"
  url "https://github.com/hpcng/singularity/releases/download/v3.8.2/singularity-3.8.2.tar.gz"
  sha256 "996611dec402b4d372b8b9456dd9ec1cb43712d08502e455f38521bd199856d3"
  license "BSD-3-Clause"

  depends_on "go" => :build
  depends_on "openssl@1.1" => :build
  depends_on "libarchive"
  depends_on :linux
  depends_on "pkg-config"
  depends_on "squashfs"
  depends_on "util-linux" # for libuuid

  def install
    system "./mconfig", "--prefix=#{prefix}"
    cd "./builddir" do
      system "make"
      system "make", "install"
    end
  end

  test do
    assert_match "There are 0 container file(s)", shell_output("#{bin}/singularity cache list")
  end
end
