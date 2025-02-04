class Epstool < Formula
  desc "Edit preview images and fix bounding boxes in EPS files"
  homepage "http://www.ghostgum.com.au/software/epstool.htm"
  url "https://deb.debian.org/debian/pool/main/e/epstool/epstool_3.09.orig.tar.xz"
  sha256 "1e85249d1a44f9418b1f95a3aebd8b0784dab8e49deb6417ac9b996ca08f6011"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?epstool[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4e5bf8b004fc2583bedd3fd7f28b49033b55be2a53e73a2b600a6f0c795d7db8"
    sha256 cellar: :any_skip_relocation, big_sur:       "a743d9856f51f4f2405adc5c692784897a78ecbdaa9361390b84c5630c077021"
    sha256 cellar: :any_skip_relocation, catalina:      "3ef026d6cc575da86e43741df6a9f5419269bea22e8db6c6296811112678c690"
    sha256 cellar: :any_skip_relocation, mojave:        "497608077aea90c569aab7929a8a9ea19d91ba70f4743d982bcb63c1d3a48d7b"
    sha256 cellar: :any_skip_relocation, high_sierra:   "47ab226f0e5d93a3b91b43d519de370d046410946e280958ef9106fdbc4ef115"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2cfb5dcc505aedf5e1882bd9f0307b772d5d6eb1033856709470bf81c201372c" # linuxbrew-core
  end

  depends_on "ghostscript"

  def install
    system "make", "install",
                   "EPSTOOL_ROOT=#{prefix}",
                   "EPSTOOL_MANDIR=#{man}",
                   "CC=#{ENV.cc}"
  end

  test do
    system bin/"epstool", "--add-tiff-preview", "--device", "tiffg3", test_fixtures("test.eps"), "test2.eps"
    assert_predicate testpath/"test2.eps", :exist?
  end
end
