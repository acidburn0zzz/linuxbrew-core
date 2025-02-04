class Otf2bdf < Formula
  desc "OpenType to BDF font converter"
  homepage "http://sofia.nmsu.edu/~mleisher/Software/otf2bdf/"
  url "http://sofia.nmsu.edu/~mleisher/Software/otf2bdf/otf2bdf-3.1.tbz2"
  sha256 "3d63892e81187d5192edb96c0dc6efca2e59577f00e461c28503006681aa5a83"

  livecheck do
    url :homepage
    regex(/href=.*?otf2bdf[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "077dfdbef2ee5d04e9101f64cfe6da40631d8ea685e2fd6dfe052bfd0374bcf0"
    sha256 cellar: :any, big_sur:       "3feac6fe8b055277c8b4174415f5974fc082019ab1b82c8c582fbf9f8de581d0"
    sha256 cellar: :any, catalina:      "200d4f317f5fda0c3c4a350ba773322af4a29af56a65f9e3de11b406ab517522"
    sha256 cellar: :any, mojave:        "76e89f43b017f0bc2f90c3d49e70d75ac9da5260b9567d1078449f1b80af60bf"
    sha256 cellar: :any, high_sierra:   "208ef317e3c51e88818c4f59ca0333a76d6efeed97b04affe66c3cd6b601bada"
    sha256 cellar: :any, x86_64_linux:  "f04564d10f3b4e3288fb918729a633f56d09f4ba1cec4898a91ad00f9b34b506" # linuxbrew-core
  end

  depends_on "freetype"

  on_linux do
    resource "test-font" do
      url "https://raw.githubusercontent.com/paddykontschak/finder/master/fonts/LucidaGrande.ttc"
      sha256 "e188b3f32f5b2d15dbf01e9b4480fed899605e287516d7c0de6809d8e7368934"
    end
  end

  resource "mkinstalldirs" do
    url "http://sofia.nmsu.edu/~mleisher/Software/otf2bdf/mkinstalldirs"
    sha256 "e7b13759bd5caac0976facbd1672312fe624dd172bbfd989ffcc5918ab21bfc1"
  end

  def install
    buildpath.install resource("mkinstalldirs")
    chmod 0755, "mkinstalldirs"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    on_macos do
      assert_match "MacRoman", shell_output("#{bin}/otf2bdf -et /System/Library/Fonts/LucidaGrande.ttc")
    end
    on_linux do
      resource("test-font").stage do
        assert_match "MacRoman", shell_output("#{bin}/otf2bdf -et LucidaGrande.ttc")
      end
    end
  end
end
