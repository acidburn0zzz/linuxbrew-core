class Alpine < Formula
  desc "News and email agent"
  homepage "https://alpine.x10host.com/alpine/release/"
  url "https://alpine.x10host.com/alpine/release/src/alpine-2.25.tar.xz"
  sha256 "658a150982f6740bb4128e6dd81188eaa1212ca0bf689b83c2093bb518ecf776"
  license "Apache-2.0"
  head "https://repo.or.cz/alpine.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?alpine[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "582a949310304de5e5be76778082fbf28b4eaaabe601e47cc9a5fdd8cd5d9d11"
    sha256 big_sur:       "665cbc225d2214eec23be609aa4e2bec422b828777bd11b9c64f50b202fc3f6b"
    sha256 catalina:      "bc7aa25d88c44fc92fe74fbef139588917066a5c0648e4cc03565fe4cd095ff7"
    sha256 mojave:        "8d2da04c056a637f0e437550e49c3fb4e7d0145a1efc28c59bcfe0e0eee8f519"
    sha256 x86_64_linux:  "5e7129395e301cfc72f8b78df95d3cb940696677a2f5c29ddeb48736b4ea424c" # linuxbrew-core
  end

  depends_on "openssl@1.1"

  uses_from_macos "ncurses"
  uses_from_macos "openldap"

  on_linux do
    depends_on "linux-pam"
  end

  def install
    ENV.deparallelize

    args = %W[
      --disable-debug
      --with-ssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-ssl-certs-dir=#{etc}/openssl@1.1
      --prefix=#{prefix}
      --with-bundled-tools
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/alpine", "-conf"
  end
end
